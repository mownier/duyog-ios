//
//  MusicPlayerInteractor.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class MusicPlayerInteractor: MusicPlayerInteractorInputProtocol {

    weak var output: MusicPlayerInteractorOutputProtocol?
    
    func playSongWithRemoteURLPath(_ path: String) {
        output?.onPlayProgress(0.1)
    }
}
