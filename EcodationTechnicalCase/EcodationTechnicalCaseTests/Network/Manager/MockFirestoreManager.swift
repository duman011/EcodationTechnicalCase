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
    
    // Filmek favoriye eklenmesini taklit eder.
    func addMovieToFavorite(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        // İşlem başarılı olduğunu simüle ederek onSuccess fonksiyonunu çağırır.
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
    
    // Favorilerden film kaldırma işlemini taklit eder.
    func removeFromFavorites(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        // İşlem başarılı olduğunu simüle ederek onSuccess fonksiyonunu çağırır.
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
    
    // Bir filmın favori olup olmadığını kontrol etmeyi taklit eder.
    func isFavorited(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        // Filmın favori olduğunu simüle ederek onSuccess fonksiyonunu
        invokedIsFavorited = true
        invokedIsFavoritedCount += 1
        invokedIsFavoritedParameters = (movie: movie, ())
        invokedIsFavoritedParametersList.append((movie: movie, ()))
        onSuccess(true)
    }
    
    
    var invokedGetMoviesFromFavorites = false
    var invokedGetMoviesFromFavoritesCount = 0
    
    // Favori film listesini alma işlemini taklit eder.
    func getMoviesFromFavorites(onSuccess: @escaping ([EcodationTechnicalCase.Movie]) -> Void, onError: @escaping (String) -> Void) {
        // İşlem başarılı olduğunu simüle ederek onSuccess fonksiyonunu çağırır.
        invokedGetMoviesFromFavorites = true
        invokedGetMoviesFromFavoritesCount += 1
        onSuccess([MockData.mockMovie])
    }
    
    var invokedAddMovieToWatchList = false
    var invokedAddMovieToWatchListCount = 0
    var invokedAddMovieToWatchListParameters: (movie: Movie, Void)?
    var invokedAddMovieToWatchListParametersList = [(movie: Movie, Void)]()
    
    // Bir filmi izleme listesine eklemeyi taklit eder.
    func addMovieToWatchList(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        // İşlem başarılı olduğunu simüle ederek onSuccess fonksiyonunu çağırır.
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
    
    // Bir filmi izleme listesinden kaldırmayı taklit eder.
    func removeFromWatchList(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        // İşlem başarılı olduğunu simüle ederek onSuccess fonksiyonunu çağırır.
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
    // Bir filmın izleme listesinde olup olmadığını kontrol etmeyi taklit eder.
    func isWatchList(movie: EcodationTechnicalCase.Movie, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        // Filmın izleme listesinde olduğunu simüle ederek onSuccess fonksiyonunu çağırır.
        invokedIsWatchList  = true
        invokedIsWatchListCount += 1
        invokedIsWatchListParameters = (movie: movie, ())
        invokedIsWatchListParametersList.append((movie: movie, ()))
        onSuccess(true)
    }
    
    var invokedGetMoviesFromWatchList = false
    var invokedGetMoviesFromWatchListCount = 0
    
    // İzleme listesindeki filmleri alma işlemini taklit eder.
    func getMoviesFromWatchList(onSuccess: @escaping ([EcodationTechnicalCase.Movie]) -> Void, onError: @escaping (String) -> Void) {
        // İşlem başarılı olduğunu simüle ederek onSuccess fonksiyonunu çağırır.
        invokedGetMoviesFromWatchList = true
        invokedGetMoviesFromWatchListCount += 1
        onSuccess([MockData.mockMovie])
    }
}
