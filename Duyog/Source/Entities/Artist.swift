//
//  Artist.swift
//  Duyog
//
//  Created by Mounir Ybanez on 05/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

struct Artist: Hashable {
    
    var id: String
    var name: String
    var bio: String
    var genre: String
    
    var hashValue: Int {
        return id.hashValue
    }
    
    init(id: String, name: String = "", bio: String = "", genre: String = "") {
        self.id = id
        self.name = name
        self.bio = bio
        self.genre = genre
    }
    
    static func ==(lhs: Artist, rhs: Artist) -> Bool {
        return lhs.id == rhs.id && !lhs.id.isEmpty && !rhs.id.isEmpty
    }
    
    struct Collection {
        
        var artist: Artist
        var albums: [Album]
        var songs: [Song.CollectionItem]
        
        var songCount: Int { return songs.count }
        
        init(artist: Artist, albums: [Album] = [], songs: [Song.CollectionItem] = []) {
            self.artist = artist
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
    }
}
