//
//  MockData.swift
//  EcodationTechnicalCaseTests
//
//  Created by Yaşar Duman on 16.01.2024.
//

@testable import EcodationTechnicalCase

struct MockData {
    // MARK: - Mock Movie
    static let mockMovie: EcodationTechnicalCase.Movie = {
       
        return EcodationTechnicalCase.Movie(id: 0, original_title: "", original_name: "", overview: "", poster_path: "", media_type: "", release_date: "", first_air_date: "", vote_average: 0.5, vote_count: 1)
    }()
    
    static let mockMovieResponse: EcodationTechnicalCase.MovieResponse = {
        return EcodationTechnicalCase.MovieResponse(results: [mockMovie])
    }()
    
}
