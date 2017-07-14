//
//  MusicPlayerInteractor.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import AVFoundation

class MusicPlayerInteractor: MusicPlayerInteractorInputProtocol {

    var output: MusicPlayerInteractorOutputProtocol!
    var songs: [Song.Data]
    var service: AVPlayerServiceProtocol
    var indexGenerator: MusicPlayerIndexGeneratorProtocol
    
    init(songs: [Song.Data], service: AVPlayerServiceProtocol, indexGenerator: MusicPlayerIndexGeneratorProtocol) {
        self.songs = songs
        self.service = service
        self.indexGenerator = indexGenerator
    }
    
    func load() {
        guard songs.count > 0 else { return }
        
        output.onLoadSongs(songs)
        output.onRepeat(indexGenerator.isRepeated)
        output.onShuffle(indexGenerator.isShuffled)
        output.onAdjustVolume(service.volume)
        playNext()
    }
    
    func playSong(_ index: Int) {
        guard index >= 0 && index < songs.count else { return }
        
        output.onPrepareSong(index)
        output.canPlayPrevious(indexGenerator.hasHistory)
        output.canPlayNext(index < songs.count - 1 || indexGenerator.isShuffled || indexGenerator.isRepeated)
        
        let status = service.prepareToPlay(songs[index].song.streamURL)
        switch status {
        case .ok: play()
        default: break
        }
    }
    
    func pause() {
        let status = service.pause()
        switch status {
        case .ok: output.onPause()
        default: break
        }
    }
    
    func play() {
        let status = service.play()
        switch status {
        case .ok: output.onPlay()
        case .noPlayableItem: playNext()
        default: break
        }   
    }
    
    func playNext() {
        if let index = indexGenerator.next {
            playSong(index)
            
        } else if !service.isPlaying {
            output.onPause()
        }
    }
    
    func playPrevious() {
        if let index = indexGenerator.previous {
            playSong(index)
            
        } else if !service.isPlaying {
            output.onPause()
        }
    }
    
    func toggleRepeat() {
        indexGenerator.isRepeated = !indexGenerator.isRepeated
        output.onRepeat(indexGenerator.isRepeated)
    }
    
    func toggleShuffle() {
        indexGenerator.isShuffled = !indexGenerator.isShuffled
        output.onShuffle(indexGenerator.isShuffled)
    }

    func togglePlay() {
        if service.isPlaying { pause() } else { play() }
    }
    
    func adjustVolume(_ value: Float) {
        service.volume = value
        output.onAdjustVolume(value)
    }
}

extension MusicPlayerInteractor: AVPlayerServiceDelegate {
    
    func onPlaying(_ progress: Double, duration: Double) {
        output.onPlaying(progress, duration: duration)
    }
    
    func onEnd() {
        playNext()
    }
}
