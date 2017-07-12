//
//  MusicPlayerAssembly.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MusicPlayerAssembly: MusicPlayerAssemblyProtocol {
    
    var generator: MusicPlayerViewControllerGeneratorProtocol!
    
    init(generator: MusicPlayerViewControllerGeneratorProtocol) {
        self.generator = generator
    }
    
    func assemble(songs: [Song.Data], moduleOutput: MusicPlayerModuleOutputProtocol?) -> UIViewController {
        let viewController = generator.generate()
        let interactor = MusicPlayerInteractor(songs: songs)
        let presenter = MusicPlayerPresenter()
        
        interactor.output = presenter
        presenter.output = viewController
        
        viewController.interactor = interactor
        viewController.moduleOutput = moduleOutput
        
        return viewController as! UIViewController
    }
}
