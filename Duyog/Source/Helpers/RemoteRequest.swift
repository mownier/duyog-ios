//
//  RemoteRequest.swift
//  Duyog
//
//  Created by Mounir Ybanez on 21/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

enum RemoteRequestMethod {
    
    case post, get, put, delete
    
    var httpMethod: String {
        switch self {
        case .post: return "POST"
        case .get: return "GET"
        case .put: return "PUT"
        case .delete: return "DELETE"
        }
    }
}

struct RemoteRequestAttrib {
    
    var url: String
    var method: RemoteRequestMethod
    var data: [AnyHashable: Any]
    var header: [String: String]
    
    init(url: String = "", method: RemoteRequestMethod = .get, data: [AnyHashable: Any] = [:], header: [String: String] = [:]) {
        self.url = url
        self.method = method
        self.data = data
        self.header = header
    }
}

protocol RemoteRequest {

    func requestWithAttrib(_ attrib: RemoteRequestAttrib, ok: @escaping (Data) -> Void, err: @escaping (Error) -> Void)
}


class JSONRemoteRequest: RemoteRequest {

    private var session: URLSession
    private var json: JSONSerializer
    private var requestBuilder: URLRequestBuilder
    
    init(session: URLSession = URLSession.shared, requestBuilder: URLRequestBuilder = RemoteURLRequestBuilder(), json: JSONSerializer = JSONParser()) {
        self.session = session
        self.json = json
        self.requestBuilder = requestBuilder
    }
    
    func requestWithAttrib(_ attrib: RemoteRequestAttrib, ok: @escaping (Data) -> Void, err: @escaping (Error) -> Void) {
        guard let url = URL(string: attrib.url) else {
            err(ServiceError("URL is not valid"))
            return
        }
        
        var request = requestBuilder.buildWithURL(url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = attrib.method.httpMethod
        
        if !attrib.data.isEmpty && attrib.method != .get {
            let result = json.encoder.encode(attrib.data)
            
            switch result {
            case .err: return err(ServiceError("Request body is not JSON"))
            case .ok(let data): request.httpBody = data
            }
        }
        
        for (key, value) in attrib.header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        let task = session.dataTask(with: request) { data, resp, error in
            guard error != nil else {
                err(error!)
                return
            }
            
            guard resp == nil else {
                err(ServiceError("response is nil"))
                return
            }
            
            guard data == nil else {
                err(ServiceError("response data is nil"))
                return
            }
            
            let httpError = self.handleHTTPResponse(resp as? HTTPURLResponse, data!)
            
            guard httpError == nil else {
                err(httpError!)
                return
            }
            
            
            ok(data!)
        }
        
        task.resume()
    }
    
    private func handleHTTPResponse(_ resp: HTTPURLResponse?, _ data: Data) -> Error? {
        guard let httpResp = resp else {
            return ServiceError("response is not HTTPURLResponse")
        }
        
        guard httpResp.statusCode >= 400 else {
            return nil
        }
        
        switch json.decoder.decode(data) {
        case .err(let error):
            return error
        
        case .ok(let info):
            guard let info = info as? [AnyHashable: Any], let message = info["error"] as? String else {
                return ServiceError("can not decode error message")
            }
            
            return ServiceError(message)
        }
    }
}
