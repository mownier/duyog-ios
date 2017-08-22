//
//  Auth.swift
//  Duyog
//
//  Created by Mounir Ybanez on 21/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

struct Auth {
    
    var accessToken: String
    var refreshToken: String
    var userKey: String
    var email: String
    var expiry: Int64
    
    init() {
        accessToken = ""
        refreshToken = ""
        userKey = ""
        email = ""
        expiry = 0
    }
}
