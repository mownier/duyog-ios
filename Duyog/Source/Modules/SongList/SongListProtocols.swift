//
//  SongListProtocols.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol SongListInteractorInputProtocol: class {
    
    func load()
    func fetchSongs()
    func selectSongsToPlay(_ type: SongListPlayType)
}

protocol SongListInteractorOutputProtocol: class {
    
    func onLoad(_ title: String)
    func didFetchSongs(_ type: InteractorSongListType)
    func willPlaySongs(_ songs: [Song.Data])
}

protocol SongListPresenterOutputProtocol: class {
    
    func displayTitle(_ title: String)
    func displaySongs(_ type: PresenterSongListType)
    func playSongs(_ songs: [Song.Data])
}

protocol SongListModuleOutputProtocol: class {
    
}

protocol SongListAssemblyProtocol: class {
    
    var generator: SongListViewControllerGeneratorProtocol! { get }
    
    func assemble(type: InteractorSongListType, moduleOutput: SongListModuleOutputProtocol?) -> UIViewController
}

protocol SongListViewControllerProtocol: class {
    
    var interactor: SongListInteractorInputProtocol! { set get }
    var moduleOutput: SongListModuleOutputProtocol? { set get }
}

protocol SongListViewControllerGeneratorProtocol: class {
    
    func generate() -> SongListViewControllerProtocol & SongListPresenterOutputProtocol
}
