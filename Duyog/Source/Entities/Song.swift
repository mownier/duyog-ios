//
//  Song.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

struct Song: Hashable {
    
    var id: String
    var title: String
    var genre: String
    var duration: Double
    var streamURL: String
    
    var hashValue: Int {
        return id.hashValue
    }
    
    init(id: String, title: String = "", genre: String = "", duration: Double = 0, streamURL: String = "") {
        self.id = id
        self.title = title
        self.genre = genre
        self.duration = duration
        self.streamURL = streamURL
    }

    static func ==(lhs: Song, rhs: Song) -> Bool {
        return lhs.id == rhs.id && !lhs.id.isEmpty && !rhs.id.isEmpty
    }
    
    struct CollectionItem: Hashable {
        
        var song: Song
        var artists: [String]
        var albums: [String]
        
        init(song: Song, artists: [String], albums: [String]) {
            self.song = song
            self.artists = artists
            self.albums = albums
        }
        
        var hashValue: Int {
            return song.hashValue
        }
        
        static func ==(lhs: CollectionItem, rhs: CollectionItem) -> Bool {
            return lhs == rhs
        }
    }
    
    struct Collection {
        
        var songs: [Song.CollectionItem]
        var albums: [Album]
        var artists: [Artist]
        
        init(songs: [Song.CollectionItem], albums: [Album], artists: [Artist]) {
            self.songs = Array(Set(songs))
            self.albums = Array(Set(albums))
            self.artists = Array(Set(artists))
        }
        
        subscript(index: Int) -> (Song, [Album], [Artist])? {
            guard index >= 0 && index < songs.count else { return nil }
            
            let song = songs[index].song
            let album = albums.filter({ songs[index].albums.contains($0.id) })
            let artist = artists.filter({ songs[index].artists.contains($0.id) })
            
            return (song, album, artist)
        }
    }
}

