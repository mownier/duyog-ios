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
            type = InteractorSongListType.album(Album.Collection(album: Album(id: "")))
            
        case .artist:
            type = InteractorSongListType.artist(Artist.Collection(artist: Artist(id: "")))
            
        case .playlist:
            type = InteractorSongListType.playlist(Playlist.Collection(playlist: Playlist(id: "")))
        }
        output.didFetchSongs(type)
    }
    
    func selectSongsToPlay(_ playType: SongListPlayType) {
        switch playType {
        case .all:
            switch type {
            case .album(let collection):
                let songs = Song.Collection(songs: collection.songs, albums: [collection.album], artists: collection.artists)
                output.willPlaySongs(songs)
            
            case .artist(let collection):
                let songs = Song.Collection(songs: collection.songs, albums: collection.albums, artists: [collection.artist])
                output.willPlaySongs(songs)
                
            case .playlist(let collection):
                let songs = Song.Collection(songs: collection.songs, albums: collection.albums, artists: collection.artists)
                output.willPlaySongs(songs)
            }
        
        case .selected(let indices):
            switch type {
            case .album(let collection):
                var songs: [Song.CollectionItem] = []
                var artists: [Artist] = []

                for (index, song) in collection.songs.enumerated() {
                    guard indices.contains(index) else { continue }
                    
                    songs.append(song)
                    
                    for artist in collection.artist(index) {
                        guard !artists.contains(artist) else { continue }
                        
                        artists.append(artist)
                    }
                }
                
                let collectionSongs = Song.Collection(songs: songs, albums: [collection.album], artists: artists)
                output.willPlaySongs(collectionSongs)
                
            case .artist(let collection):
                var songs: [Song.CollectionItem] = []
                var albums: [Album] = []
                
                for (index, song) in collection.songs.enumerated() {
                    guard indices.contains(index) else { continue }
                    
                    songs.append(song)
                    
                    for album in collection.album(index) {
                        guard !albums.contains(album) else { continue }
                        
                        albums.append(album)
                    }
                }
                
                let collectionSongs = Song.Collection(songs: songs, albums: albums, artists: [collection.artist])
                output.willPlaySongs(collectionSongs)
                
            case .playlist(let collection):
                var songs: [Song.CollectionItem] = []
                var albums: [Album] = []
                var artists: [Artist] = []
                
                for (index, song) in collection.songs.enumerated() {
                    guard indices.contains(index) else { continue }
                    
                    songs.append(song)
                    
                    for album in collection.album(index) {
                        guard !albums.contains(album) else { continue }
                        
                        albums.append(album)
                    }
                    
                    for artist in collection.artist(index) {
                        guard !artists.contains(artist) else { continue }
                        
                        artists.append(artist)
                    }
                }
                
                let collectionSongs = Song.Collection(songs: songs, albums: albums, artists: artists)
                output.willPlaySongs(collectionSongs)
            }
        }
    }
}
