//
//  UserServiceRoute.swift
//  Duyog
//
//  Created by Mounir Ybanez on 22/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

protocol UserServiceRoute {
    
    var register: String { get }
    var getInfo: String { get }
    var getPlaylists: String { get }
}

struct UserRemoteServiceRoute: UserServiceRoute {
    
    var register: String
    var getInfo: String
    var getPlaylists: String
    
    init(reader: PlistReader = PlistResourceReader(), name: String = "DataServiceRoute") {
        self.register = ""
        self.getInfo = ""
        self.getPlaylists = ""
        
        switch reader.read(name) {
        case .ok(let info):
            guard let info = info as? [String: String] else {
                break
            }
            
            guard let baseURL = info["base_url"], !baseURL.isEmpty else {
                break
            }
            
            guard let version = info["version"], !version.isEmpty else {
                break
            }
            
            if let register = info["user_register"], !register.isEmpty {
                self.register = "\(baseURL)/\(version)/\(register)"
            }
            
            if let getInfo = info["user_get_info"], !getInfo.isEmpty {
                self.getInfo = "\(baseURL)/\(version)/\(getInfo)"
            }
            
            if let getPlaylists = info["user_get_playlists"], !getPlaylists.isEmpty {
                self.getInfo = "\(baseURL)/\(version)/\(getPlaylists)"
            }
            
        default: break
        }
    }
}
