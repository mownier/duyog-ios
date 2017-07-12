//
//  FlowModule.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import UIKit

protocol FlowModuleProtocol {
    
    var id: String { get }
}

enum FlowModule: FlowModuleProtocol {
    
    case songList
    case musicPlayer
    
    var id: String {
        switch self {
        case .songList: return "SongList"
        case .musicPlayer: return "MusicPlayer"
        }
    }
}

extension FlowControllerProtocol {
    
    func showSongList(_ state: FlowState, type: InteractorSongListType, moduleOutput: SongListModuleOutputProtocol? = nil, generator: SongListViewControllerGeneratorProtocol = SongListViewControllerGenerator()) {
        let assembly = SongListAssembly(generator: generator)
        let child = assembly.assemble(type: type, moduleOutput: moduleOutput)
        enter(state, module: FlowModule.songList, viewController: child)
    }
    
    func showMusicPlayer(_ state: FlowState, songs: [Song.Data], moduleOutput: MusicPlayerModuleOutputProtocol? = nil, generator: MusicPlayerViewControllerGeneratorProtocol = MusicPlayerViewControllerGenerator()) {
        let assembly = MusicPlayerAssembly(generator: generator)
        let child = assembly.assemble(songs: songs, moduleOutput: moduleOutput)
        enter(state, module: FlowModule.musicPlayer, viewController: child)
    }
}

