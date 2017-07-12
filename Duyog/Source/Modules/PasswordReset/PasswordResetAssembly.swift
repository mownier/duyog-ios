//
//  PasswordResetAssembly.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class PasswordResetAssembly: PasswordResetAssemblyProtocol {
    
    var generator: PasswordResetViewControllerGeneratorProtocol!
    
    init(generator: PasswordResetViewControllerGeneratorProtocol) {
        self.generator = generator
    }
    
    func assemble(moduleOutput: PasswordResetModuleOutputProtocol?) -> UIViewController {
        let viewController = generator.generate()
        let interactor = PasswordResetInteractor()
        let presenter = PasswordResetPresenter()
        
        interactor.output = presenter
        presenter.output = viewController
        
        viewController.interactor = interactor
        viewController.moduleOutput = moduleOutput
        
        return viewController as! UIViewController
    }
}
