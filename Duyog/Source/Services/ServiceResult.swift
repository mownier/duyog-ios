//
//  ServiceResult.swift
//  Duyog
//
//  Created by Mounir Ybanez on 21/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

struct ServiceError: Error {
    
    private(set) var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

enum ServiceResult<D> {
    
    case succeeded(D)
    case failed(Error)
}
