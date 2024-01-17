//
//  APICaller.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import Foundation


protocol NetworkServiceInterface {
    /// Belirtilen sorgu ile film arama API isteği yapar.
      /// - Parameters:
      ///   - query: Aranacak film adı veya kelime.
      /// - Returns: Film yanıtını temsil eden bir `MovieResponse` nesnesi.
    func search(with query: String) async throws -> MovieResponse
}

final class NetworkService: NetworkServiceInterface {
    //MARK: - Properties
    static let shared = NetworkService()
    private let decoder = JSONDecoder()
    private let manager: URLSession
    
    //MARK: - Initializers
    private init() {
           self.manager = NetworkService.getSession()
    }
    
    // MARK: - Get Session
    /// URL Session örneği alır.
    /// - Returns: Oluşturulan URLSession örneği.
    private static func getSession() -> URLSession {
           let configuration = URLSessionConfiguration.default
        
            // İsteklerin yanıtını beklemek için en fazla 20 saniye bekleyecek.
           configuration.timeoutIntervalForResource = 20
        
            // Bir isteğin tamamlanması için en fazla 20 saniye bekleyecek.
           configuration.timeoutIntervalForRequest = 20
        
           // Her iki önbelleği de yok sayacak şekilde yapılandırılıyor.
           configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
           return URLSession(configuration: configuration)
    }
    
    // MARK: - Default URL Component
    /// Temel URL bileşenini oluşturur.
    /// - Parameters:
    ///   - path: API yolunu temsil eden bir dize.
    ///   - queries: API sorgu parametreleri.
    /// - Returns: Oluşturulan URL bileşeni.
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

    
    // MARK: - Search Movie
    /// Belirtilen sorgu ile film arama API isteği yapar.
    /// - Parameters:
    ///   - query: Aranacak film adı veya kelime.
    /// - Returns: Film yanıtını temsil eden bir `MovieResponse` nesnesi.
    func search(with query: String) async throws -> MovieResponse {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            throw MovieError.invalidUrl
        }
        
        let queries = ["api_key": Endpoint.searchMovie.apiKey, "query": encodedQuery]
        
        guard let url = URL(string: getURLComponent(path: Endpoint.searchMovie.path, queries: queries)) else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await manager.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode  else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }

}
