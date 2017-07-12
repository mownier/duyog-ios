//
//  SignInPresenter.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class SignInPresenter: SignInInteractorOutputProtocol {

    weak var output: SignInPresenterOutputProtocol!

    func onSignIn(_ result: SignInResult) {
        switch result {
        case .ok: output.onSignInOk()
        case .error: output.onSignInError("Error", message: "Something went wrong")
        }
    }
}
