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
    
    var hashValue: Int { return id.hashValue }
    
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
    
    struct Data: Hashable {
        
        var song: Song
        var artists: [Artist]
        var albums: [Album]
        
        var hashValue: Int { return song.hashValue }
        
        init(song: Song, artists: [Artist] = [], albums: [Album] = []) {
            self.song = song
            self.artists = artists
            self.albums = albums
        }
        
        static func ==(lhs: Data, rhs: Data) -> Bool {
            return lhs.song == rhs.song
        }
    }
}
