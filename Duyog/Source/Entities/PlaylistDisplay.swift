//
//  PlaylistDisplay.swift
//  Duyog
//
//  Created by Mounir Ybanez on 11/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

extension Playlist {
    
    struct Display {
        
        var nameText: String
        var descriptionText: String
        
        init(nameText: String = "", descriptionText: String = "") {
            self.nameText = nameText
            self.descriptionText = descriptionText
        }
        
        struct Item {
            
            var playlist: Playlist.Display
            var songs: [Song.Display.Item]
            
            init(playlist: Playlist.Display, songs: [Song.Display.Item] = []) {
                self.playlist = playlist
                self.songs = songs
            }
        }
    }
}
