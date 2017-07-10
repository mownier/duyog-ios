//
//  MusicPlayerProtocols.swift
//  Duyog
//
//  Created by Mounir Ybanez on 04/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MusicPlayerViewOutputProtocol: class {
    
    func play()
    func pause()
    func playNext()
    func playPrevious()
}

protocol MusicPlayerViewInputProtocol: class {
    
    func onPlay()
    func onPause()
    func onPlayNext()
    func onPlayPrevious()
    func onPlayProgress(_ progress: Float, text: String)
}

protocol MusicPlayerPresenterProtocol: class {
    
    var view: MusicPlayerViewInputProtocol! { get }
    var interactor: MusicPlayerInteractorInputProtocol! { get }
    var router: MusicPlayerRouterInputProtocol! { get }
    var output: MusicPlayerModuleOutputProtocol? { get }
}

protocol MusicPlayerInteractorInputProtocol: class {
    
    func playSongWithRemoteURLPath(_ path: String)
}

protocol MusicPlayerInteractorOutputProtocol: class {
    
    func onPlayProgress(_ progress: Float)
}

protocol MusicPlayerRouterInputProtocol: class {
    
}

protocol MusicPlayerModuleInputProtocol: class {
    
    static func create(_ songs: [MusicPlayerSongProtocol], output: MusicPlayerModuleOutputProtocol?) -> UIViewController
}

protocol MusicPlayerModuleOutputProtocol: class {
    
    func didPlaySong(_ song: MusicPlayerSongProtocol)
}
