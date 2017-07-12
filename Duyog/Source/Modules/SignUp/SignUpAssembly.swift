//
//  SignUpAssembly.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class SignUpAssembly: SignUpAssemblyProtocol {
    
    var generator: SignUpViewControllerGeneratorProtocol!
    
    init(generator: SignUpViewControllerGeneratorProtocol) {
        self.generator = generator
    }
    
    func assemble(moduleOutput: SignUpModuleOutputProtocol?) -> UIViewController {
        let viewController = generator.generate()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        
        interactor.output = presenter
        presenter.output = viewController
        
        viewController.interactor = interactor
        viewController.moduleOutput = moduleOutput
        
        return viewController as! UIViewController
    }
}
