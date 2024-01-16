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
    func addMovieToWatchList(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void)
    func removeFromWatchList(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void)
    func isWatchList (movie: Movie, onSuccess: @escaping (Bool) -> Void, onError: @escaping (String) -> Void)
    func getMoviesFromFavorites(onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void)
    
    
    
}

final class FirestoreManager: FirestoreManagerInterface {
    //MARK: - Properties
    static let shared = FirestoreManager()
    private let currentUserRef = Firestore.firestore().collection("UsersInfo").document(ApplicationVariables.currentUserID!)
    
    //MARK: - Initializers
    private init() {}
    
    //MARK: - Favorites Functions
    func addMovieToFavorite(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        
        let movieRef = currentUserRef
            .collection("favorites")
            .document(String(movie.id))
        
        let data: [String: Any] = [
            "id": movie.id,
            "original_title": movie.original_title ?? "",
            "original_name": movie.original_name ?? "",
            "overview": movie.overview ?? "",
            "poster_path": movie.poster_path ?? "",
            "media_type": movie.media_type ?? "",
            "release_date": movie.release_date ?? "",
            "first_air_date": movie.first_air_date ?? "",
            "vote_average": movie.vote_average ?? 0.0,
            "vote_count": movie.vote_count ?? 0
        ]as [String : Any]
        
        FirestoreService.shared.setData(reference: movieRef, data: data) {
            onSuccess()
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
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
    
    
    //MARK: - WatchList Functions
    func addMovieToWatchList(movie: Movie, onSuccess: @escaping () -> Void, onError: @escaping (String) -> Void) {
        
        let movieRef = currentUserRef
            .collection("watchList")
            .document(String(movie.id))
        
        let data: [String: Any] = [
            "id": movie.id,
            "original_title": movie.original_title ?? "",
            "original_name": movie.original_name ?? "",
            "overview": movie.overview ?? "",
            "poster_path": movie.poster_path ?? "",
            "media_type": movie.media_type ?? "",
            "release_date": movie.release_date ?? "",
            "first_air_date": movie.first_air_date ?? "",
            "vote_average": movie.vote_average ?? 0.0,
            "vote_count": movie.vote_count ?? 0
        ]as [String : Any]
        
        FirestoreService.shared.setData(reference: movieRef, data: data) {
            onSuccess()
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
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
    
    func getMoviesFromFavorites(onSuccess: @escaping ([Movie]) -> Void, onError: @escaping (String) -> Void) {
        let favoritesRef = currentUserRef
            .collection("favorites")
        
        FirestoreService.shared.getDocuments(reference: favoritesRef) { (favorites: [Movie]) in
            onSuccess(favorites)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
}
