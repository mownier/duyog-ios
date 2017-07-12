//
//  PasswordResetPresenter.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class PasswordResetPresenter: PasswordResetInteractorOutputProtocol {

    weak var output: PasswordResetPresenterOutputProtocol!
    
    func onResetPassword(_ result: PasswordResetResult) {
        switch result {
        case .ok: output.onResetPasswordOk()
        case .error: output.onResetPasswordError("Error", message: "Something went wrong")
        }
    }
}
