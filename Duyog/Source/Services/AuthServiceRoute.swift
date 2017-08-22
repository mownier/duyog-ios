//
//  AuthServiceRoute.swift
//  Duyog
//
//  Created by Mounir Ybanez on 22/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

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
