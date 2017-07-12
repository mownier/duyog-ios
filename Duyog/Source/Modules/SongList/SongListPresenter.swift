//
//  SongListPresenter.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class SongListPresenter: SongListInteractorOutputProtocol {
    
    weak var output: SongListPresenterOutputProtocol!
    
    func didFetchSongs(_ type: InteractorSongListType) {
        switch type {
        case .album:
            let item = Album.Display.Item(album: Album.Display(), songs: [])
            output.displaySongs(PresenterSongListType.album(item))
            
        case .artist:
            let item = Artist.Display.Item(artist: Artist.Display(), songs: [])
            output.displaySongs(PresenterSongListType.artist(item))
            
        case .playlist:
            let item = Playlist.Display.Item(playlist: Playlist.Display(), songs: [])
            output.displaySongs(PresenterSongListType.playlist(item))
        }
    }
    
    func willPlaySongs(_ songs: [Song.Data]) {
        output.playSongs(songs)
    }
}
