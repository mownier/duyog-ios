//
//  HomePresenter.swift
//  Duyog
//
//  Created by Mounir Ybanez on 12/07/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

class HomePresenter: HomeInteractorOutputProtocol {

    weak var output: HomePresenterOutputProtocol!
    
    func didFetchData() {
        output.displayData()
    }
}
