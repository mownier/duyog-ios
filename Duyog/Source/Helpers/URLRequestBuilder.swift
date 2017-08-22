//
//  URLRequestBuilder.swift
//  Duyog
//
//  Created by Mounir Ybanez on 22/08/2017.
//  Copyright © 2017 Ner. All rights reserved.
//

import Foundation

protocol URLRequestBuilder {
    
    func buildWithURL(_ url: URL) -> URLRequest
}

class RemoteURLRequestBuilder: URLRequestBuilder {
    
    func buildWithURL(_ url: URL) -> URLRequest {
        let request = URLRequest(url: url)
        return request
    }
}
