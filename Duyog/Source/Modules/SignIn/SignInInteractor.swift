//
//  SignInInteractor.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class SignInInteractor: SignInInteractorInputProtocol {

    var output: SignInInteractorOutputProtocol!
    
    func sigIn(email: String, password: String) {
        output.onSignIn(.ok)
    }
}
