//
//  MockNetworkService.swift
//  EcodationTechnicalCaseTests
//
//  Created by Yaşar Duman on 16.01.2024.
//

@testable import EcodationTechnicalCase

final class MockNetworkService: NetworkServiceInterface{
    var invokedSearch = false
    var invokedSearchCount = 0
    
    // search fonksiyonunu taklit eder
    func search(with query: String) async throws -> EcodationTechnicalCase.MovieResponse {
        invokedSearch = true
        invokedSearchCount += 1
        
        // Mock verileri kullanarak bir MovieResponse nesnesi döndürür.
        return MockData.mockMovieResponse
    }
    
}
