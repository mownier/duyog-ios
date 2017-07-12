//
//  MusicPlayerProtocols.swift
//  Duyog
//
//  Created by Mounir Ybanez on 04/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MusicPlayerInteractorInputProtocol: class {
    
    func playSong(_ index: Int)
    func playNext()
    func playPrevious()
    
    func togglePlay()
    func toggleShuffle()
    func toggleRepeat()
    
    func load()
}

protocol MusicPlayerInteractorOutputProtocol: class {
    
    func onPlay(_ progress: Double, song: Song.Data)
    func onPause(_ progress: Double, song: Song.Data)
    
    func onShuffle(_ enabled: Bool)
    func onRepeat(_ enabled: Bool)
    
    func onLoadSongs(_ songs: [Song.Data])
    
    func onPrepareSong(_ index: Int)
}

protocol MusicPlayerPresenterOutputProtocol: class {
    
    func displaySongs(_ songs: [Song.Display.Item])
    
    func displayOnPlay(_ progress: Double, elapsedText: String)
    func displayOnPause(_ progress: Double, elapsedText: String)
    
    func displayOnShuffle(_ enabled: Bool)
    func displayOnRepeat(_ enabled: Bool)
    
    func prepareDisplayOnPlay(_ index: Int)
}

protocol MusicPlayerModuleOutputProtocol: class {
    
}

protocol MusicPlayerAssemblyProtocol: class {
    
    var generator: MusicPlayerViewControllerGeneratorProtocol! { get }
    
    func assemble(songs: [Song.Data], moduleOutput: MusicPlayerModuleOutputProtocol?) -> UIViewController
}

protocol MusicPlayerViewControllerProtocol: class {
    
    var interactor: MusicPlayerInteractorInputProtocol! { set get }
    var moduleOutput: MusicPlayerModuleOutputProtocol? { set get }
}

protocol MusicPlayerViewControllerGeneratorProtocol: class {
    
    func generate() -> MusicPlayerViewControllerProtocol & MusicPlayerPresenterOutputProtocol
}
