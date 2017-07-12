//
//  AlbumDisplay.swift
//  Duyog
//
//  Created by Mounir Ybanez on 11/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

extension Album {
    
    struct Display {
        
        var photoURLPath: String
        var nameText: String
        var yearText: String
        
        init(photoURLPath: String = "", nameText: String = "", yearText: String = "") {
            self.photoURLPath = photoURLPath
            self.nameText = nameText
            self.yearText = yearText
        }
        
        struct Item {
            
            var album: Album.Display
            var songs: [Song.Display.Item]
            
            init(album: Album.Display, songs: [Song.Display.Item] = []) {
                self.album = album
                self.songs = songs
            }
        }
    }
}
