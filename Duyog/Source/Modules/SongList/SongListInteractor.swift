//
//  SongListInteractor.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class SongListInteractor: SongListInteractorInputProtocol {
    
    var output: SongListInteractorOutputProtocol!
    var type: InteractorSongListType
    
    init(type: InteractorSongListType) {
        self.type = type
    }
    
    func load() {
        switch type {
        case .album: output.onLoad("album")
        case .artist: output.onLoad("artist")
        case .playlist: output.onLoad("playlist")
        }
        
        fetchSongs()
    }
    
    func fetchSongs() {
        output.didFetchSongs(type)
    }
    
    func selectSongsToPlay(_ playType: SongListPlayType) {
        switch playType {
        case .all:
            switch type {
            case .album(let data):
                output.willPlaySongs(data.songs)
            
            case .artist(let data):
                output.willPlaySongs(data.songs)
                
            case .playlist(let data):
                output.willPlaySongs(data.songs)
            }
        
        case .selected(let indices):
            switch type {
            case .album(let data):
                output.willPlaySongs(data.songs.enumerated().filter({ indices.contains($0.offset) }).map({ $0.element }))
                
            case .artist(let data):
                output.willPlaySongs(data.songs.enumerated().filter({ indices.contains($0.offset) }).map({ $0.element }))
                
            case .playlist(let data):
                output.willPlaySongs(data.songs.enumerated().filter({ indices.contains($0.offset) }).map({ $0.element }))
            }
        }
    }
}
