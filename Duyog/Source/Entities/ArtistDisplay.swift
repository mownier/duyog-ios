//
//  ArtistDisplay.swift
//  Duyog
//
//  Created by Mounir Ybanez on 11/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

extension Artist {
    
    struct Display {
        
        var nameText: String
        var bioText: String
        var genreText: String
        
        init(nameText: String = "", bioText: String = "", genreText: String = "") {
            self.nameText = nameText
            self.bioText = bioText
            self.genreText = genreText
        }
        
        struct Item {
            
            var artist: Artist.Display
            var songs: [Song.Display.Item]
            
            init(artist: Artist.Display, songs: [Song.Display.Item] = []) {
                self.artist = artist
                self.songs = songs
            }
        }
    }
}
