//
//  User.swift
//  Duyog
//
//  Created by Mounir Ybanez on 22/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

struct User {
    
    var key: String
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String
    
    var hasInfo: Bool {
        return key.isEmpty && email.isEmpty && firstName.isEmpty && lastName.isEmpty && avatar.isEmpty
    }
    
    init(key: String = "", email: String = "", firstName: String = "", lastName: String = "", avatar: String = "") {
        self.key = key
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
    
    init(_ info: [AnyHashable: Any]) {
        self.init()
        if let key = info["id"] as? String {
            self.key = key
        }
        
        
        if let email = info["email"] as? String {
            self.email = email
        }
        
        if let firstName = info["first_name"] as? String {
            self.firstName = firstName
        }
        
        if let lastName = info["last_name"] as? String {
            self.lastName = lastName
        }
        
        if let avatar = info["avatar"] as? String {
            self.avatar = avatar
        }
    }
}
