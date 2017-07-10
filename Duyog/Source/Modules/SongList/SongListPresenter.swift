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
            output.displaySongs(PresenterSongListType.album(SongListDisplayAlbum.Collection(album: SongListDisplayAlbum())))
            
        case .artist:
            output.displaySongs(PresenterSongListType.artist(SongListDisplayArtist.Collection(artist: SongListDisplayArtist())))
            
        case .playlist:
            output.displaySongs(PresenterSongListType.playlist(SongListDisplayPlaylist.Collection(playlist: SongListDisplayPlaylist())))
        }
    }
    
    func willPlaySongs(_ songs: Song.Collection) {
        output.playSongs(songs)
    }
}
