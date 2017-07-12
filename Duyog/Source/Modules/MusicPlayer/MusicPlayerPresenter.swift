//
//  MusicPlayerPresenter.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

class MusicPlayerPresenter: MusicPlayerInteractorOutputProtocol {
    
    weak var output: MusicPlayerPresenterOutputProtocol!
    
    lazy var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    func onPrepareSong(_ index: Int) {
        output.prepareDisplayOnPlay(index)
    }
    
    func onPlay(_ progress: Double, song data: Song.Data) {
        output.displayOnPlay(progress, elapsedText: formatter.string(from: progress * data.song.duration) ?? "")
    }
    
    func onPause(_ progress: Double, song data: Song.Data) {
        output.displayOnPause(progress, elapsedText: formatter.string(from: progress * data.song.duration) ?? "")
    }
    
    func onRepeat(_ enabled: Bool) {
        output.displayOnRepeat(enabled)
    }
    
    func onShuffle(_ enabled: Bool) {
        output.displayOnShuffle(enabled)
    }
    
    func onLoadSongs(_ songs: [Song.Data]) {
        output.displaySongs(songs.map({ data in
            let song = Song.Display(titleText: data.song.title, genreText: data.song.genre, durationText: formatter.string(from: data.song.duration) ?? "")
            let artists = data.artists.map({ Artist.Display(nameText: $0.name, bioText: $0.bio, genreText: $0.genre) })
            let albums = data.albums.map({ Album.Display.init(photoURLPath: $0.photoURL, nameText: $0.name, yearText: "\($0.year)") })
            return Song.Display.Item(song: song, artists: artists, albums: albums)
        }))
    }
    
    func onPrepareNextSong(_ index: Int) {
        
    }
    
    func onPreparePreviousSong(_ index: Int) {
        
    }
}
