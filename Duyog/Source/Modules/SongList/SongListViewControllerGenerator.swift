//
//  SongListViewControllerGenerator.swift
//  Duyog
//
//  Created by Mounir Ybanez on 10/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class SongListViewControllerGenerator: SongListViewControllerGeneratorProtocol {
    
    func generate() -> SongListViewControllerProtocol & SongListPresenterOutputProtocol {
        return SongListViewController()
    }
}

