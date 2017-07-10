//
//  MusicPlayerPresenter.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol MusicPlayerSongProtocol {
    
    var duration: Float { get }
    var titleText: String { get }
    var albumPhotoURLPath: String { get }
    var artistText: String { get }
}

class MusicPlayerPresenter: MusicPlayerPresenterProtocol {

    var router: MusicPlayerRouterInputProtocol!
    var view: MusicPlayerViewInputProtocol!
    var interactor: MusicPlayerInteractorInputProtocol!
    weak var output: MusicPlayerModuleOutputProtocol?
    
    var songs: [MusicPlayerSongProtocol] = []
}

extension MusicPlayerPresenter: MusicPlayerViewOutputProtocol {
    
    func play() {
        view.onPlay()
    }
    
    func playNext() {
        view.onPlayNext()
    }
    
    func playPrevious() {
        view.onPlayPrevious()
    }
    
    func pause() {
        view.onPause()
    }
}

extension MusicPlayerPresenter: MusicPlayerInteractorOutputProtocol {
    
    func onPlayProgress(_ progress: Float) {
        view.onPlayProgress(progress, text: "\(progress)")
    }
}
