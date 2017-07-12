//
//  SongListModels.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

typealias InteractorSongListType = SongListType<Artist.Data, Album.Data, Playlist.Data>
typealias PresenterSongListType = SongListType<Artist.Display.Item, Album.Display.Item, Playlist.Display.Item>

enum SongListType<Artist, Album, Playlist> {
    
    case artist(Artist)
    case album(Album)
    case playlist(Playlist)
}

enum SongListPlayType {
    
    case all
    case selected([Int])
}
