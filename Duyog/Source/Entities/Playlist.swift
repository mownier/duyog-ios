//
//  Playlist.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

struct Playlist: Hashable {
    
    var id: String
    var name: String
    var description: String
    var photoURL: String
    
    var hashValue: Int {
        return id.hashValue
    }
    
    init(id: String, name: String = "", description: String = "", photoURL: String = "") {
        self.id = id
        self.name = name
        self.description = description
        self.photoURL = photoURL
    }
    
    static func ==(lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.id == rhs.id && !lhs.id.isEmpty && !rhs.id.isEmpty
    }
    
    struct Collection {
        
        var playlist: Playlist
        var artists: [Artist]
        var albums: [Album]
        var songs: [Song.CollectionItem]
        
        var songCount: Int { return songs.count }
        
        init(playlist: Playlist, artists: [Artist] = [], albums: [Album] = [], songs: [Song.CollectionItem] = []) {
            self.playlist = playlist
            self.artists = Array(Set(artists))
            self.albums = Array(Set(albums))
            self.songs = Array(Set(songs))
        }
        
        func song(_ index: Int) -> Song? {
            guard index >= 0 && index < songs.count else { return nil }
            
            return songs[index].song
        }
        
        func album(_ index: Int) -> [Album] {
            guard index >= 0 && index < songs.count else { return [] }
            
            return albums.filter({ songs[index].albums.contains($0.id) })
        }
        
        func artist(_ index: Int) -> [Artist] {
            guard index >= 0 && index < songs.count else { return [] }
            
            return artists.filter({ songs[index].artists.contains($0.id) })
        }
    }
}
