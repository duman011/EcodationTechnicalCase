//
//  FirestoreManager.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 16.01.2024.
//

import Foundation


import FirebaseFirestore

protocol FirestoreManagerInterface {
    func addMovieToFavorite(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void)
    func removeFromFavorites(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void)
    func isFavorited (movie: Movie, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void)
    func getMoviesFromFavorites(onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void)
    
    func addMovieToWatchList(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void)
    func removeFromWatchList(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void)
    func isWatchList (movie: Movie, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void)
    func getMoviesFromWatchList(onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void)
}

final class FirestoreManager: FirestoreManagerInterface {
    //MARK: - Properties
    static let shared = FirestoreManager()
    private let currentUserRef = Firestore.firestore().collection("UsersInfo").document(ApplicationVariables.currentUserID!)
    
    //MARK: - Initializers
    private init() {}
    
    
    //MARK: - Favorites Functions
    
    /// Favorilere film eklemeyi sağlayan fonksiyon.
    /// - Parameters:
    ///   - movie: Favorilere eklenecek film.
    ///   - onSuccess: Favori ekleme işlemi başarılı olduğunda çağrılacak olan @escaping bloğu.
    ///   - onError: Favori ekleme işlemi başarısız olduğunda çağrılacak olan @escaping bloğu.
    func addMovieToFavorite(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        let movieRef = currentUserRef
            .collection("favorites")
            .document(String(movie.id))
        
        let data: [String: Any] = [
            "id": movie.id,
            "original_title": movie.original_title ?? "",
            "overview": movie.overview ?? "",
            "poster_path": movie.poster_path ?? "",
            "backdrop_path": movie.poster_path ?? "",
            "release_date": movie.release_date ?? "",
            "vote_average": movie.vote_average ?? 0.0,
        ]as [String : Any]
        
        FirestoreService.shared.setData(reference: movieRef, data: data) {
            onSuccess()
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    /// Favorilerden film çıkarmayı sağlayan fonksiyon.
    func removeFromFavorites(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        let movieRef = currentUserRef
            .collection("favorites")
            .document(String(movie.id))
        
        FirestoreService.shared.deleteDocument(reference: movieRef) {
            onSuccess()
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    /// Film favorilerde mi kontrolünü sağlayan fonksiyon.
    func isFavorited (movie: Movie, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        let movieRef = currentUserRef
            .collection("favorites")
            .document(String(movie.id))
        
        FirestoreService.shared.checkDocumentExists(reference: movieRef) { exists in
            onSuccess(exists)
        } onError: { error in
            print(error.localizedDescription)
        }
    }
    
    /// Kullanıcının favori filmlerini getiren fonksiyon.
    func getMoviesFromFavorites(onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void) {
        let favoritesRef = currentUserRef
            .collection("favorites")
        
        FirestoreService.shared.getDocuments(reference: favoritesRef) { (favorites: [Movie]) in
            onSuccess(favorites)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    
    //MARK: - WatchList Functions
    
    /// İzleme listesine film eklemeyi sağlayan fonksiyon.
        /// - Parameters:
        ///   - movie: İzleme listesine eklenecek film.
        ///   - onSuccess: İzleme listesine ekleme işlemi başarılı olduğunda çağrılacak olan kapanış bloğu.
        ///   - onError: İzleme listesine ekleme işlemi başarısız olduğunda çağrılacak olan kapanış bloğu.
    func addMovieToWatchList(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        
        let movieRef = currentUserRef
            .collection("watchList")
            .document(String(movie.id))
        
        let data: [String: Any] = [
            "id": movie.id,
            "original_title": movie.original_title ?? "",
            "overview": movie.overview ?? "",
            "poster_path": movie.poster_path ?? "",
            "backdrop_path": movie.poster_path ?? "",
            "release_date": movie.release_date ?? "",
            "vote_average": movie.vote_average ?? 0.0,
        ]as [String : Any]
        
        FirestoreService.shared.setData(reference: movieRef, data: data) {
            onSuccess()
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    /// İzleme listesinden film çıkarmayı sağlayan fonksiyon.
    func removeFromWatchList(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        let movieRef = currentUserRef
            .collection("watchList")
            .document(String(movie.id))
        
        FirestoreService.shared.deleteDocument(reference: movieRef) {
            onSuccess()
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    /// Film izleme listesinde mi kontrolünü sağlayan fonksiyon.
    func isWatchList (movie: Movie, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void) {
        let movieRef = currentUserRef
            .collection("watchList")
            .document(String(movie.id))
        
        FirestoreService.shared.checkDocumentExists(reference: movieRef) { exists in
            onSuccess(exists)
        } onError: { error in
            print(error.localizedDescription)
        }
    }
    
    /// Kullanıcının İzleme Listesindeki filmlerini getiren fonksiyon.
    func getMoviesFromWatchList(onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void) {
        let favoritesRef = currentUserRef
            .collection("watchList")
        
        FirestoreService.shared.getDocuments(reference: favoritesRef) { (favorites: [Movie]) in
            onSuccess(favorites)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
}
