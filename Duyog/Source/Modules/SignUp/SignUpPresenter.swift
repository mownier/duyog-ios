//
//  SignUpPresenter.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class SignUpPresenter: SignUpInteractorOutputProtocol {
    
    weak var output: SignUpPresenterOutputProtocol!
    
    func onSignUp(_ result: SignUpResult) {
        switch result {
        case .ok: output.onSignUpOk()
        case .error: output.onSignUpError("Error", message: "Something went wrong")
        }
    }
}
