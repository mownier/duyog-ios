//
//  HomeInteractor.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class HomeInteractor: HomeInteractorInputProtocol {

    var output: HomeInteractorOutputProtocol!
    
    func fetchData() {
        output.didFetchData()
    }
}
