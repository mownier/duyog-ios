//
//  MusicPlayerAssembly.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

class MusicPlayerAssembly: MusicPlayerModuleInputProtocol {
    
    static func create(_ songs: [MusicPlayerSongProtocol], output: MusicPlayerModuleOutputProtocol? = nil) -> UIViewController {
        let presenter = MusicPlayerPresenter()
        let router = MusicPlayerRouter()
        let interactor = MusicPlayerInteractor()
        let view = MusicPlayerViewController()

        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.output = output
        presenter.songs = songs

        view.output = presenter
        interactor.output = presenter
        
        router.viewController = view
        
        return view
    }
}
