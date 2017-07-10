//
//  SongListAssembly.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class SongListAssembly: SongListAssemblyProtocol {
    
    var generator: SongListViewControllerGeneratorProtocol!
    
    init(generator: SongListViewControllerGeneratorProtocol) {
        self.generator = generator
    }
    
    func assemble(type: InteractorSongListType, moduleOutput: SongListModuleOutputProtocol?) -> UIViewController {
        let viewController = generator.generate()
        let interactor = SongListInteractor(type: type)
        let presenter = SongListPresenter()
        
        interactor.output = presenter
        presenter.output = viewController
        
        viewController.interactor = interactor
        viewController.moduleOutput = moduleOutput
        
        return viewController as! UIViewController
    }
}
