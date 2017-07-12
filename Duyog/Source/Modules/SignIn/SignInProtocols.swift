//
//  SignInProtocols.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol SignInInteractorInputProtocol: class {
    
    func sigIn(email: String, password: String)
}

protocol SignInInteractorOutputProtocol: class {
    
    func onSignIn(_ result: SignInResult)
}

protocol SignInPresenterOutputProtocol: class {
    
    func onSignInError(_ title: String, message: String)
    func onSignInOk()
}

protocol SignInModuleOutputProtocol: class {
    
}

protocol SignInAssemblyProtocol: class {
    
    var generator: SignInViewControllerGeneratorProtocol! { get }
    
    func assemble(moduleOutput: SignInModuleOutputProtocol?) -> UIViewController
}

protocol SignInViewControllerProtocol: class {
    
    var interactor: SignInInteractorInputProtocol! { set get }
    var moduleOutput: SignInModuleOutputProtocol? { set get }
}

protocol SignInViewControllerGeneratorProtocol: class {
    
    func generate() -> SignInViewControllerProtocol & SignInPresenterOutputProtocol
}
