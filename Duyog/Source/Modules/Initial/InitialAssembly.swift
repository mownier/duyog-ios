//
//  InitialAssembly.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class InitialAssembly: InitialAssemblyProtocol {

    var generator: InitialViewControllerGeneratorProtocol!
    
    init(generator: InitialViewControllerGeneratorProtocol) {
        self.generator = generator
    }
    
    func assemble(moduleOutput: InitialModuleOutputProtocol?) -> UIViewController {
        let viewController = generator.generate()
        let interactor = InitialInteractor()
        
        let signInInteractor = SignInInteractor()
        let signUpInteractor = SignUpInteractor()
        let passwordResetInteractor = PasswordResetInteractor()
        
        let signInPresenter = SignInPresenter()
        let signUpPresenter = SignUpPresenter()
        let passwordResetPresenter = PasswordResetPresenter()
        
        signInInteractor.output = signInPresenter
        signUpInteractor.output = signUpPresenter
        passwordResetInteractor.output = passwordResetPresenter
        
        signInPresenter.output = viewController
        signUpPresenter.output = viewController
        passwordResetPresenter.output = viewController
        
        interactor.signIn = signInInteractor
        interactor.signUp = signUpInteractor
        interactor.passwordReset = passwordResetInteractor
        
        viewController.moduleOutput = moduleOutput
        viewController.interactor = interactor
        
        return viewController as! UIViewController
    }
}
