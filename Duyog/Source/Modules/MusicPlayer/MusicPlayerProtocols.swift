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
    func adjustVolume(_ volume: Float)
}

protocol MusicPlayerInteractorOutputProtocol: class {
    
    func onPlaying(_ progress: Double, duration: Double)
    func onPlay()
    func onPause()
    
    func onShuffle(_ enabled: Bool)
    func onRepeat(_ enabled: Bool)
    
    func onLoadSongs(_ songs: [Song.Data])
    
    func onPrepareSong(_ index: Int)
    
    func canPlayPrevious(_ canPlay: Bool)
    func canPlayNext(_ canPlay: Bool)
    
    func onAdjustVolume(_ volume: Float)
}

protocol MusicPlayerPresenterOutputProtocol: class {
    
    func displaySongs(_ songs: [Song.Display.Item])
    
    func displayOnPlay()
    func displayOnPause()
    func displayOnPlaying(_ progress: Double, elapsedText: String)
    
    func displayOnShuffle(_ enabled: Bool)
    func displayOnRepeat(_ enabled: Bool)
    
    func prepareDisplayOnPlay(_ index: Int)
    func enableNext(_ isEnabled: Bool)
    func enablePrevious(_ isEnabled: Bool)
    
    func displayOnVolumeAdjustment(_ volume: Float)
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

protocol MusicPlayerIndexGeneratorProtocol: class {
    
    var isRepeated: Bool { set get }
    var isShuffled: Bool { set get }
    
    var next: Int? { get }
    var previous: Int? { get }
    var hasHistory: Bool { get }
    
    func queue(_ indices: [Int])
}
