//
//  InitialProtocols.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

typealias InitialPresenterOutputProtocol = SignInPresenterOutputProtocol & SignUpPresenterOutputProtocol & PasswordResetPresenterOutputProtocol

protocol InitialInteractorInputProtocol {
    
    var signIn: SignInInteractorInputProtocol! { set get }
    var signUp: SignUpInteractorInputProtocol! { set get }
    var passwordReset: PasswordResetInteractorInputProtocol! { set get }
}

protocol InitialModuleOutputProtocol: class {
    
    var signIn: SignInModuleOutputProtocol? { set get }
    var signUp: SignUpModuleOutputProtocol? { set get }
    var passwordReset: PasswordResetModuleOutputProtocol? { set get }
}

protocol InitialAssemblyProtocol: class {
    
    var generator: InitialViewControllerGeneratorProtocol! { get }
    
    func assemble(moduleOutput: InitialModuleOutputProtocol?) -> UIViewController
}

protocol InitialViewControllerProtocol: class {
    
    var interactor: InitialInteractorInputProtocol! { set get }
    var moduleOutput: InitialModuleOutputProtocol? { set get }
}

protocol InitialViewControllerGeneratorProtocol: class {
    
    func generate() -> InitialViewControllerProtocol & InitialPresenterOutputProtocol
}
