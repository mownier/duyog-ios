//
//  PasswordResetInteractor.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class PasswordResetInteractor: PasswordResetInteractorInputProtocol {

    var output: PasswordResetInteractorOutputProtocol!
    
    func resetPassword(for email: String) {
        output.onResetPassword(.ok)
    }
}
