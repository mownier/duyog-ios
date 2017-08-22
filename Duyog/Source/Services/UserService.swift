//
//  UserService.swift
//  Duyog
//
//  Created by Mounir Ybanez on 22/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

protocol UserService: class {
    
    func register(firstName: String, lastName: String, completion: @escaping (ServiceResult<User>) -> Void)
    func getInfo(key: String, completion: @escaping (ServiceResult<User>) -> Void)
    func getPlaylists(key: String, completion: @escaping (ServiceResult<Playlists>) -> Void)
}

class UserRemoteService: UserService {

    private(set) var route: UserServiceRoute
    private var accessToken: String
    private var request: RemoteRequest
    private var json: JSONDecoder
    private var header: [String: String] {
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    init(accessToken: String, route: UserServiceRoute = UserRemoteServiceRoute(), request: RemoteRequest = JSONRemoteRequest(), json: JSONDecoder = JSONDecodeAgent()) {
        self.accessToken = accessToken
        self.route = route
        self.request = request
        self.json = json
    }
    
    func register(firstName: String, lastName: String, completion: @escaping (ServiceResult<User>) -> Void) {
        let attrib = RemoteRequestAttrib(url: route.register, method: .post, data: ["first_name": firstName, "last_name": lastName], header: header)
        request.requestWithAttrib(attrib, ok: { data in
            switch self.decodeUserData(data) {
            case .err(let error):
                return completion(.failed(error))
            
            case .ok(let user):
                return completion(.succeeded(user))
            }
        }) { error in
            completion(.failed(error))
        }
    }
    
    func getInfo(key: String, completion: @escaping (ServiceResult<User>) -> Void) {
        let attrib = RemoteRequestAttrib(url: String(format: route.getInfo, key), header: header)
        
        request.requestWithAttrib(attrib, ok: { data in
            switch self.decodeUserData(data) {
            case .err(let error):
                return completion(.failed(error))
                
            case .ok(let user):
                return completion(.succeeded(user))
            }
        }) { error in
            completion(.failed(error))
        }
    }
    
    func getPlaylists(key: String, completion: @escaping (ServiceResult<Playlists>) -> Void) {
        let attrib = RemoteRequestAttrib(url: String(format: route.getPlaylists, key), header: header)
        
        request.requestWithAttrib(attrib, ok: { data in
            switch self.decodePlaylistsData(data) {
            case .err(let error):
                return completion(.failed(error))
                
            case .ok(let playlists):
                return completion(.succeeded(playlists))
            }
        }) { error in
            completion(.failed(error))
        }
    }
    
    private func decodePlaylistsData(_ data: Data) -> JSONCoderResult<Playlists> {
        let info: [AnyHashable: Any]
        
        switch json.decode(data) {
        case .err(let error):
            return .err(error)
            
        case .ok(let dict):
            guard dict is [AnyHashable: Any] else {
                return .err(ServiceError("decoded playlists info is not a dictionary"))
            }
            
            info = dict as! [AnyHashable: Any]
        }
        
        var playlists = Playlists()
        
        if let creators = info["creators"] as? [String: [AnyHashable: Any]] {
            for (key, info) in creators {
                playlists.creators[key] = User(info)
            }
        }
        
        if let list = info["playlists"] as? [String: [AnyHashable: Any]] {
            for (key, info) in list {
                playlists.list[key] = Playlist(info)
            }
        }
        
        return .ok(playlists)
    }
    
    private func decodeUserData(_ data: Data) -> JSONCoderResult<User> {
        let info: [AnyHashable: Any]
        
        switch json.decode(data) {
        case .err(let error):
            return .err(error)
        
        case .ok(let dict):
            guard dict is [AnyHashable: Any] else {
                return .err(ServiceError("decoded user info is not a dictionary"))
            }
            
            info = dict as! [AnyHashable: Any]
        }
        
        let user = User(info)
        
        if user.hasInfo {
            return .err(ServiceError("user has no information"))
        }
        
        return .ok(user)
    }
}
