//
//  MockFirestoreManager.swift
//  EcodationTechnicalCaseTests
//
//  Created by Yaşar Duman on 17.01.2024.
//

@testable import EcodationTechnicalCase

final class MockFirestoreManager: FirestoreManagerInterface {
    
    var invokedAddMovieToFavorite = false
    var invokedAddMovieToFavoriteCount = 0
    var invokedAddMovieToFavoriteParameters: (movie: Movie, Void)?
    var invokedAddMovieToFavoriteParametersList = [(movie: Movie, Void)]()

    func addMovieToFavorite(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        invokedAddMovieToFavorite = true
        invokedAddMovieToFavoriteCount += 1
        invokedAddMovieToFavoriteParameters = (movie: movie, ())
        invokedAddMovieToFavoriteParametersList.append((movie: movie, ()))
        onSuccess()
    }
    
    var invokedRemoveFromFavorites = false
    var invokedRemoveFromFavoritesCount = 0
    var invokedRemoveFromFavoritesParameters: (movie: Movie, Void)?
    var invokedRemoveFromFavoritesParametersList = [(movie: Movie, Void)]()
    
    func removeFromFavorites(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        invokedRemoveFromFavorites = true
        invokedRemoveFromFavoritesCount += 1
        invokedRemoveFromFavoritesParameters = (movie: movie, ())
        invokedRemoveFromFavoritesParametersList.append((movie: movie, ()))
        onSuccess()
    }
    
    var invokedIsFavorited = false
    var invokedIsFavoritedCount = 0
    var invokedIsFavoritedParameters: (movie: Movie, Void)?
    var invokedIsFavoritedParametersList = [(movie: Movie, Void)]()
    
    func isFavorited(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        invokedIsFavorited = true
        invokedIsFavoritedCount += 1
        invokedIsFavoritedParameters = (movie: movie, ())
        invokedIsFavoritedParametersList.append((movie: movie, ()))
        onSuccess(true)
    }
    
    var invokedGetMoviesFromFavorites = false
    var invokedGetMoviesFromFavoritesCount = 0

    func getMoviesFromFavorites(onSuccess: @escaping ([EcodationTechnicalCase.Movie]) -> Void, onError: @escaping (String) -> Void) {
        invokedGetMoviesFromFavorites = true
        invokedGetMoviesFromFavoritesCount += 1
        onSuccess([MockData.mockMovie])
    }
    
    var invokedAddMovieToWatchList = false
    var invokedAddMovieToWatchListCount = 0
    var invokedAddMovieToWatchListParameters: (movie: Movie, Void)?
    var invokedAddMovieToWatchListParametersList = [(movie: Movie, Void)]()
    
    func addMovieToWatchList(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        invokedAddMovieToWatchList = true
        invokedAddMovieToWatchListCount += 1
        invokedAddMovieToWatchListParameters = (movie: movie, ())
        invokedAddMovieToWatchListParametersList.append((movie: movie, ()))
        onSuccess()
    }
    
    var invokedRemoveFromWatchList = false
    var invokedRemoveFromWatchListCount = 0
    var invokedRemoveFromWatchListParameters: (movie: Movie, Void)?
    var invokedRemoveFromWatchListParametersList = [(movie: Movie, Void)]()
    
    func removeFromWatchList(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        invokedRemoveFromWatchList = true
        invokedRemoveFromWatchListCount += 1
        invokedRemoveFromWatchListParameters = (movie: movie, ())
        invokedRemoveFromWatchListParametersList.append((movie: movie, ()))
        onSuccess()
    }
    
    var invokedIsWatchList = false
    var invokedIsWatchListCount = 0
    var invokedIsWatchListParameters: (movie: Movie, Void)?
    var invokedIsWatchListParametersList = [(movie: Movie, Void)]()
    
    func isWatchList(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        invokedIsWatchList  = true
        invokedIsWatchListCount += 1
        invokedIsWatchListParameters = (movie: movie, ())
        invokedIsWatchListParametersList.append((movie: movie, ()))
        onSuccess(true)
    }
    
    var invokedGetMoviesFromWatchList = false
    var invokedGetMoviesFromWatchListCount = 0

    func getMoviesFromWatchList(onSuccess: @escaping ([EcodationTechnicalCase.Movie]) -> Void, onError: @escaping (String) -> Void) {
        invokedGetMoviesFromWatchList = true
        invokedGetMoviesFromWatchListCount += 1
        onSuccess([MockData.mockMovie])
    }
}
