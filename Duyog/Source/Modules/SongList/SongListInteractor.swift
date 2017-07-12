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
    
    func fetchSongs() {
        switch type {
        case .album:
            let newData = Album.Data(album: Album(id: ""), songs: [])
            type = InteractorSongListType.album(newData)
            
        case .artist:
            let newData = Artist.Data(artist: Artist(id: ""), songs: [])
            type = InteractorSongListType.artist(newData)
            
        case .playlist:
            let newData = Playlist.Data(playlist: Playlist(id: ""), songs: [])
            type = InteractorSongListType.playlist(newData)

        }
        
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
