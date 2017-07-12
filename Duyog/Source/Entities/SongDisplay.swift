//
//  SongDisplay.swift
//  Duyog
//
//  Created by Mounir Ybanez on 11/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

extension Song {
    
    struct Display {
        
        var titleText: String
        var genreText: String
        var durationText: String
        
        init(titleText: String = "", genreText: String = "", durationText: String = "") {
            self.titleText = titleText
            self.genreText = genreText
            self.durationText = durationText
        }
        
        struct Item {
            
            var song: Song.Display
            var artists: [Artist.Display]
            var albums: [Album.Display]
            
            init(song: Song.Display, artists: [Artist.Display] = [], albums: [Album.Display] = []) {
                self.song = song
                self.artists = artists
                self.albums = albums
            }
        }
    }
}
