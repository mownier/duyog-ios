//
//  SongListPresenter.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

class SongListPresenter: SongListInteractorOutputProtocol {
    
    weak var output: SongListPresenterOutputProtocol!
    
    lazy var formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    func onLoad(_ title: String) {
        output.displayTitle(title.uppercased())
    }
    
    func didFetchSongs(_ type: InteractorSongListType) {
        switch type {
        case .artist(let info):
            let artist = Artist.Display(nameText: info.artist.name, bioText: info.artist.bio, genreText: info.artist.genre)
            let songs = info.songs.map({ data -> Song.Display.Item in
                let display = Song.Display(titleText: data.song.title, genreText: data.song.genre, durationText: formatter.string(from: data.song.duration) ?? "")
                let albums = data.albums.map({ Album.Display(photoURLPath: $0.photoURL, nameText: $0.name, yearText: "\($0.year)") })
                let item = Song.Display.Item(song: display, artists: [artist], albums: albums)
                return item
            })
            
            let item = Artist.Display.Item(artist: artist, songs: songs)
            output.displaySongs(PresenterSongListType.artist(item))
        
        default:
            break
        }
    }
    
    func willPlaySongs(_ songs: [Song.Data]) {
        output.playSongs(songs)
    }
}
