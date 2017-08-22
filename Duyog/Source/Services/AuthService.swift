//
//  AuthService.swift
//  Duyog
//
//  Created by Mounir Ybanez on 21/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

protocol AuthService: class {
    
    func signInWithEmail(_ email: String, password: String, completion: @escaping (ServiceResult<Auth>) -> Void)
    func signUpWithEmail(_ email: String, password: String, completion: @escaping (ServiceResult<Auth>) -> Void)
    func changePasswordOfEmail(_ email: String, currentPassword: String, newPassword: String, completion: @escaping (ServiceResult<Bool>) -> Void)
    func refreshAccessToken(_ refreshToken: String, expiry: Int64, completion: @escaping (ServiceResult<Auth>) -> Void)
}

struct AuthServiceRoute {
    
    var signIn: String
    var signUp: String
    var changePass: String
    var refresh: String
    
    init(signIn: String = "", signUp: String = "", changePass: String = "", refresh: String = "") {
        self.signIn = signIn
        self.signUp = signUp
        self.changePass = changePass
        self.refresh = refresh
    }
}

class AuthRemoteService: AuthService {
    
    private(set) var route: AuthServiceRoute
    private var request: RemoteRequest
    private var apiKey: String
    private var json: JSONDecoder
    
    init(apiKey: String, route: AuthServiceRoute, request: RemoteRequest = JSONRemoteRequest(), json: JSONDecoder = JSONDecodeAgent()) {
        self.apiKey = apiKey
        self.route = route
        self.request = request
        self.json = json
    }
    
    func signInWithEmail(_ email: String, password: String, completion: @escaping (ServiceResult<Auth>) -> Void) {
        let attrib = RemoteRequestAttrib(url: route.signIn, method: .post, data: ["email": email, "password": password, "api_key": apiKey])
        request.requestWithAttrib(attrib, ok: { data in
            switch self.decodeAuthData(data) {
            case .err(let error): completion(.failed(error))
            case .ok(let auth): completion(.succeeded(auth))
            }
            
            }, err: { error in
                completion(.failed(error))
        })
    }
    
    func signUpWithEmail(_ email: String, password: String, completion: @escaping (ServiceResult<Auth>) -> Void) {
        let attrib = RemoteRequestAttrib(url: route.signUp, method: .post, data: ["email": email, "password": password, "api_key": apiKey])
        request.requestWithAttrib(attrib, ok: { data in
            switch self.decodeAuthData(data) {
            case .err(let error): completion(.failed(error))
            case .ok(let auth): completion(.succeeded(auth))
            }
            
            }, err: { error in
                completion(.failed(error))
        })
    }
    
    func changePasswordOfEmail(_ email: String, currentPassword: String, newPassword: String, completion: @escaping (ServiceResult<Bool>) -> Void) {
        let attrib = RemoteRequestAttrib(url: route.changePass, method: .post, data:["email": email, "current_password": currentPassword, "new_password": newPassword, "api_key": apiKey])
        request.requestWithAttrib(attrib, ok: { data in
            switch self.decodeChangePassData(data) {
            case .err(let error): completion(.failed(error))
            case .ok(let ok): completion(.succeeded(ok))
            }
            
            }, err: { error in
                completion(.failed(error))
        })
    }
    
    func refreshAccessToken(_ refreshToken: String, expiry: Int64, completion: @escaping (ServiceResult<Auth>) -> Void) {
        let attrib = RemoteRequestAttrib(url: route.refresh, method: .post, data:["refresh_token": refreshToken, "expiry": expiry, "api_key": apiKey])
        request.requestWithAttrib(attrib, ok: { data in
            switch self.decodeAuthData(data) {
            case .err(let error): completion(.failed(error))
            case .ok(let auth): completion(.succeeded(auth))
            }
            
            }, err: { error in
                completion(.failed(error))
        })
    }
    
    private func decodeChangePassData(_ data: Data) -> JSONCoderResult<Bool> {
        switch json.decode(data) {
        case .err(let error):
            return .err(error)
        
        case .ok:
            return .ok(true)
        }
    }
    
    private func decodeAuthData(_ data: Data) -> JSONCoderResult<Auth> {
        let info: [AnyHashable: Any]
        
        switch json.decode(data) {
        case .err(let error):
            return .err(error)
            
        case .ok(let dict):
            guard dict is [AnyHashable: Any] else {
                return .err(ServiceError("decoded auth info is not a dictionary"))
            }
            
            info = dict as! [AnyHashable: Any]
        }
        
        
        guard let accessToken = info["access_token"] as? String, !accessToken.isEmpty else {
            return .err(ServiceError("no access token"))
        }
        
        var auth = Auth()
        auth.accessToken = accessToken
        
        if let refreshToken = info["refresh_token"] as? String, !refreshToken.isEmpty {
            auth.refreshToken = refreshToken
        }
        
        if let email = info["email"] as? String, !email.isEmpty {
            auth.email = email
        }
        
        if let userKey = info["user_id"] as? String, !userKey.isEmpty {
            auth.userKey = userKey
        }
        
        if let expiry = info["expiry"] as? Int64, expiry > 0 {
            auth.expiry = expiry
        }
        
        return .ok(auth)
    }
}
