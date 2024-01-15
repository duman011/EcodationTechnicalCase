//
//  Endpoint.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 16.01.2024.
//

import Foundation

enum Endpoint {
    case searchMovie
}

protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String {get}
    var urlScheme: String {get}
    var apiKey: String {get}
}

extension Endpoint: EndpointProtocol {
    var urlScheme: String {
        return "https"
    }
    var baseURL: String {
        return "api.themoviedb.org"
    }
    var apiKey: String {
        return "9f34b030b7187aab01fbc340d02601ee"
    }
    var path: String {
        switch self {
        case .searchMovie:
            return "/3/search/movie"
        }
    }
    
    
}
