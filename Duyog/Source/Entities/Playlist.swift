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
    
    var hashValue: Int { return id.hashValue }
    
    init(id: String = "", name: String = "", description: String = "", photoURL: String = "") {
        self.id = id
        self.name = name
        self.description = description
        self.photoURL = photoURL
    }
    
    init(_ info: [AnyHashable: Any]) {
        self.init()
        
        if let id = info["id"] as? String {
            self.id = id
        }
        
        if let name = info["name"] as? String {
            self.name = name
        }
        
        if let description = info["description"] as? String {
            self.description = description
        }
        
        if let photoURL = info["photo"] as? String {
            self.photoURL = photoURL
        }
    }
    
    static func ==(lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.id == rhs.id && !lhs.id.isEmpty && !rhs.id.isEmpty
    }
    
    struct Data: Hashable {
        
        var playlist: Playlist
        var songs: [Song.Data]
        
        var hashValue: Int { return playlist.hashValue }
        
        init(playlist: Playlist, songs: [Song.Data] = []) {
            self.playlist = playlist
            self.songs = songs
        }
        
        static func ==(lhs: Data, rhs: Data) -> Bool {
            return lhs.playlist == rhs.playlist
        }
    }
}

struct Playlists {
    
    var creators: [String: User]
    var list: [String: Playlist]
    
    init(creators: [String: User] = [:], list: [String: Playlist] = [:]) {
        self.creators = creators
        self.list = list
    }
}
