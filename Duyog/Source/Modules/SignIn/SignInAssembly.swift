//
//  SignInAssembly.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class SignInAssembly: SignInAssemblyProtocol {

    var generator: SignInViewControllerGeneratorProtocol!
    
    init(generator: SignInViewControllerGeneratorProtocol) {
        self.generator = generator
    }
    
    func assemble(moduleOutput: SignInModuleOutputProtocol?) -> UIViewController {
        let viewController = generator.generate()
        let interactor = SignInInteractor()
        let presenter = SignInPresenter()
        
        interactor.output = presenter
        presenter.output = viewController
        
        viewController.interactor = interactor
        viewController.moduleOutput = moduleOutput
        
        return viewController as! UIViewController
    }
}
