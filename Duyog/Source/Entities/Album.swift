//
//  Album.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

struct Album: Hashable {
    
    var id: String
    var photoURL: String
    var name: String
    var year: Int
    
    var hashValue: Int {
        return id.hashValue
    }
    
    init(id: String, photoURL: String = "", name: String = "", year: Int = 0) {
        self.id = id
        self.photoURL = photoURL
        self.name = name
        self.year = year
    }

    static func ==(lhs: Album, rhs: Album) -> Bool {
        return lhs.id == rhs.id && !lhs.id.isEmpty && !rhs.id.isEmpty
    }
    
    struct Collection {
        
        var album: Album
        var artists: [Artist]
        var songs: [Song.CollectionItem]
        
        var songCount: Int { return songs.count }
        
        init(album: Album, artists: [Artist] = [], songs: [Song.CollectionItem] = []) {
            self.album = album
            self.artists = Array(Set(artists))
            self.songs = Array(Set(songs))
        }
        
        func song(_ index: Int) -> Song? {
            guard index >= 0 && index < songs.count else { return nil }
            
            return songs[index].song
        }
        
        func artist(_ index: Int) -> [Artist] {
            guard index >= 0 && index < songs.count else { return [] }
            
            return artists.filter({ songs[index].artists.contains($0.id) })
        }
    }
}

