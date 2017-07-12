//
//  MusicPlayerInteractor.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

class MusicPlayerInteractor: MusicPlayerInteractorInputProtocol {

    var output: MusicPlayerInteractorOutputProtocol!
    var songs: [Song.Data]
    var currentIndex: Int?
    var isRepeated: Bool = false { didSet { output?.onRepeat(isRepeated) } }
    var isShuffled: Bool = false { didSet { output?.onShuffle(isShuffled) } }
    var isPlaying: Bool = false
    
    init(songs: [Song.Data]) {
        self.songs = songs
    }
    
    func load() {
        guard songs.count > 0 else { return }
        
        output.onLoadSongs(songs)
        playSong(0)
    }
    
    func playSong(_ index: Int) {
        guard index >= 0 && index < songs.count else { return }
        
        currentIndex = index
        output.onPrepareSong(index)
        play()
    }
    
    func pause() {
        guard let index = currentIndex, index >= 0 && index < songs.count else { return }
        
        isPlaying = false
        output.onPause(0, song: songs[index])
    }
    
    func play() {
        guard let index = currentIndex, index >= 0 && index < songs.count else { return }
        
        isPlaying = true
        output.onPlay(0, song: songs[index])
    }
    
    func playNext() {
        guard let index = currentIndex else { return }
        
        var newIndex: Int?
        
        if isShuffled {
            newIndex = Int(arc4random()) % songs.count
            
        } else if index < songs.count - 1  {
            newIndex = index + 1
            
        } else if isRepeated {
            newIndex = 0
        }
        
        if newIndex != nil {
            playSong(newIndex!)
        }
    }
    
    func playPrevious() {
        guard let index = currentIndex else { return }
        
        var newIndex: Int?
        
        if isShuffled {
            newIndex = Int(arc4random()) % songs.count
            
        } else if index > 0  {
            newIndex = index - 1
            
        } else if isRepeated {
            newIndex = songs.count - 1
        }
        
        if newIndex != nil { playSong(newIndex!) }
    }
    
    func toggleRepeat() {
        isRepeated = !isRepeated
    }
    
    func toggleShuffle() {
        isShuffled = !isShuffled
    }

    func togglePlay() {
        if isPlaying { pause() } else { play() }
    }
}
