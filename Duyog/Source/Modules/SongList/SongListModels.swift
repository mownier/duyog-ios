//
//  SongListModels.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

typealias InteractorSongListType = SongListType<Artist.Collection, Album.Collection, Playlist.Collection>
typealias PresenterSongListType = SongListType<SongListDisplayArtist.Collection, SongListDisplayAlbum.Collection, SongListDisplayPlaylist.Collection>

enum SongListType<Artist, Album, Playlist> {
    
    case artist(Artist)
    case album(Album)
    case playlist(Playlist)
}

enum SongListPlayType {
    
    case all
    case selected([Int])
}

struct SongListDisplayArtist {
    
    var nameText: String
    var bioText: String
    var genreText: String
    
    init(nameText: String = "", bioText: String = "", genreText: String = "") {
        self.nameText = nameText
        self.bioText = bioText
        self.genreText = genreText
    }
    
    struct Collection {
        
        var artist: SongListDisplayArtist
        var songs: [SongListDisplaySong]
        
        init(artist: SongListDisplayArtist, songs: [SongListDisplaySong] = []) {
            self.artist = artist
            self.songs = songs
        }
    }
}

struct SongListDisplayAlbum {
    
    var photoURLPath: String
    var nameText: String
    var yearText: String
    
    init(photoURLPath: String = "", nameText: String = "", yearText: String = "") {
        self.photoURLPath = photoURLPath
        self.nameText = nameText
        self.yearText = yearText
    }
    
    struct Collection {
        
        var album: SongListDisplayAlbum
        var songs: [SongListDisplaySong]
        
        init(album: SongListDisplayAlbum, songs: [SongListDisplaySong] = []) {
            self.album = album
            self.songs = songs
        }
    }
}

struct SongListDisplayPlaylist {
    
    var nameText: String
    var descriptionText: String
    
    init(nameText: String = "", descriptionText: String = "") {
        self.nameText = nameText
        self.descriptionText = descriptionText
    }
    
    struct Collection {
        
        var playlist: SongListDisplayPlaylist
        var songs: [SongListDisplaySong]
        
        init(playlist: SongListDisplayPlaylist, songs: [SongListDisplaySong] = []) {
            self.playlist = playlist
            self.songs = songs
        }
    }
}

struct SongListDisplaySong {
    
    var titleText: String
    var genreText: String
    var durationText: String
    
    init(titleText: String = "", genreText: String = "", durationText: String = "") {
        self.titleText = titleText
        self.genreText = genreText
        self.durationText = durationText
    }
    
    struct CollectionItem {
        
        var song: SongListDisplaySong
        var album: SongListDisplayAlbum
        var artist: SongListDisplayArtist
        
        init(song: SongListDisplaySong = SongListDisplaySong(), album: SongListDisplayAlbum = SongListDisplayAlbum(), artist: SongListDisplayArtist = SongListDisplayArtist()) {
            self.song = song
            self.album = album
            self.artist = artist
        }
    }
}
