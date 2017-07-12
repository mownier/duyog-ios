//
//  SignUpProtocols.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol SignUpInteractorInputProtocol: class {
    
    func sigUp(email: String, password: String)
}

protocol SignUpInteractorOutputProtocol: class {
    
    func onSignUp(_ result: SignUpResult)
}

protocol SignUpPresenterOutputProtocol: class {
    
    func onSignUpError(_ title: String, message: String)
    func onSignUpOk()
}

protocol SignUpModuleOutputProtocol: class {
    
}

protocol SignUpAssemblyProtocol: class {
    
    var generator: SignUpViewControllerGeneratorProtocol! { get }
    
    func assemble(moduleOutput: SignUpModuleOutputProtocol?) -> UIViewController
}

protocol SignUpViewControllerProtocol: class {
    
    var interactor: SignUpInteractorInputProtocol! { set get }
    var moduleOutput: SignUpModuleOutputProtocol? { set get }
}

protocol SignUpViewControllerGeneratorProtocol: class {
    
    func generate() -> SignUpViewControllerProtocol & SignUpPresenterOutputProtocol
}
