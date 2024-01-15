//
//  APICaller.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import Foundation


protocol NetworkServiceInterface {
    func search(with query: String) async throws -> MovieResponse
}

final class NetworkService: NetworkServiceInterface {
    static let shared = NetworkService()
    private let decoder = JSONDecoder()
    private let manager: URLSession
    
    //MARK: - Initializers
    private init() {
           self.manager = NetworkService.getSession()
    }
    
    // MARK: Get Session
    private static func getSession() -> URLSession {
           let configuration = URLSessionConfiguration.default
           configuration.timeoutIntervalForResource = 20
           configuration.timeoutIntervalForRequest = 20
           configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
           return URLSession(configuration: configuration)
    }
    
    // MARK: Default URL Component
    private func getURLComponent(path: String = "/", queries: [String: String]) -> String {
        var urlComponents: URLComponents = URLComponents()
        urlComponents.scheme = Endpoint.searchMovie.urlScheme
        urlComponents.host = Endpoint.searchMovie.baseURL
        urlComponents.path = path
        var queryItems: [URLQueryItem] = []
        for (key, value) in queries {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = queryItems
        print("NetworkService--> \(urlComponents.string!) adresine istek atılıyor...")
        return urlComponents.string!
    }

    
    func search(with query: String) async throws -> MovieResponse {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            throw MovieError.invalidUrl
        }
        
        let queries = ["api_key": Endpoint.searchMovie.apiKey, "query": encodedQuery]
        
        guard let url = URL(string: getURLComponent(path: Endpoint.searchMovie.path, queries: queries)) else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode  else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }

}
