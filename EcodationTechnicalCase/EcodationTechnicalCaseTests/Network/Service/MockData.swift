//
//  MockData.swift
//  EcodationTechnicalCaseTests
//
//  Created by Yaşar Duman on 16.01.2024.
//

@testable import EcodationTechnicalCase

struct MockData {
    // MARK: - Mock Movie
    // Testlerde kullanılmak üzere önceden belirlenmiş bir film örneği.
    static let mockMovie: EcodationTechnicalCase.Movie = {
       
        return EcodationTechnicalCase.Movie(id: 0,
                                            original_title: "",
                                            overview: "",
                                            poster_path: "TestImage",
                                            backdrop_path: "TestImage",
                                            release_date: "",
                                            vote_average: 0.5)
    }()
    
    // MARK: - Mock MovieResponseovie
    static let mockMovieResponse: EcodationTechnicalCase.MovieResponse = {
        return EcodationTechnicalCase.MovieResponse(results: [mockMovie])
    }()
}
