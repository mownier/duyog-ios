//
//  SignUpInteractor.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class SignUpInteractor: SignUpInteractorInputProtocol {
    
    var output: SignUpInteractorOutputProtocol!
    
    func sigUp(email: String, password: String) {
        output.onSignUp(.ok)
    }
}
