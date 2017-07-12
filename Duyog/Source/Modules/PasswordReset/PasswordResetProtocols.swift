//
//  PasswordResetProtocols.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol PasswordResetInteractorInputProtocol: class {
    
    func resetPassword(for email: String)
}

protocol PasswordResetInteractorOutputProtocol: class {
    
    func onResetPassword(_ result: PasswordResetResult)
}

protocol PasswordResetPresenterOutputProtocol: class {
    
    func onResetPasswordError(_ title: String, message: String)
    func onResetPasswordOk()
}

protocol PasswordResetModuleOutputProtocol: class {
    
}

protocol PasswordResetAssemblyProtocol: class {
    
    var generator: PasswordResetViewControllerGeneratorProtocol! { get }
    
    func assemble(moduleOutput: PasswordResetModuleOutputProtocol?) -> UIViewController
}

protocol PasswordResetViewControllerProtocol: class {
    
    var interactor: PasswordResetInteractorInputProtocol! { set get }
    var moduleOutput: PasswordResetModuleOutputProtocol? { set get }
}

protocol PasswordResetViewControllerGeneratorProtocol: class {
    
    func generate() -> PasswordResetViewControllerProtocol & PasswordResetPresenterOutputProtocol
}
