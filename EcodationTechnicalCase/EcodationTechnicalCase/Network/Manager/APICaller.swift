//
//  APICaller.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import Foundation


struct Constants {
    static let API_KEY = "9f34b030b7187aab01fbc340d02601ee"
    static let baseURL = "https://api.themoviedb.org"
}

final class APICaller {
    static let shared = APICaller()
    let decoder = JSONDecoder()
    
    func getTrendingMovies() async throws -> MovieResponse {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
   
 
    
    func getPopular() async throws -> MovieResponse {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
    
    func getTopRated() async throws -> MovieResponse {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {
            throw MovieError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
    
    
    
    
    func search(with query: String) async throws -> MovieResponse {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {  throw MovieError.invalidUrl  }
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {
            throw MovieError.invalidUrl
        }
        
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw MovieError.invalidResponse
            }
            
            return try decoder.decode(MovieResponse.self, from: data)
        } catch {
            throw MovieError.invalidData
        }
    }
}
