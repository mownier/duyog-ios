//
//  HomeAssembly.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class HomeAssembly: HomeAssemblyProtocol {

    var generator: HomeViewControllerGeneratorProtocol!
    
    init(generator: HomeViewControllerGeneratorProtocol) {
        self.generator = generator
    }
    
    func assemble(_ moduleOutput: HomeModuleOutputProtocol? = nil) -> UIViewController {
        let viewController = generator.generate()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        
        interactor.output = presenter
        presenter.output = viewController
        
        viewController.moduleOutput = moduleOutput
        viewController.interactor = interactor
        
        return viewController as! UIViewController
    }
}
