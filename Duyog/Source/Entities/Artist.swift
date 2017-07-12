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
    
    struct Data: Hashable {
        
        var artist: Artist
        var songs: [Song.Data]
        
        var hashValue: Int { return artist.hashValue }
        
        init(artist: Artist, songs: [Song.Data] = []) {
            self.artist = artist
            self.songs = songs
        }
        
        static func ==(lhs: Data, rhs: Data) -> Bool {
            return lhs.artist == rhs.artist
        }
    }
}
