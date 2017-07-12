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
    
    struct Data: Hashable {
        
        var album: Album
        var songs: [Song.Data]
        
        var hashValue: Int { return album.hashValue }
        
        init(album: Album, songs: [Song.Data] = []) {
            self.album = album
            self.songs = songs
        }
        
        static func ==(lhs: Data, rhs: Data) -> Bool {
            return lhs.album == rhs.album
        }
    }
}
