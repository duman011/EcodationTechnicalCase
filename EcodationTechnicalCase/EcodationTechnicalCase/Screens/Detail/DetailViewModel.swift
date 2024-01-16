//
//  DetailViewModel.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//


import FirebaseFirestore
import FirebaseAuth

protocol DetailVMInterface {
    func addToFavorites(movie: Movie, completion: @escaping (Bool) -> Void)
    func removeFromFavorites(movie: Movie, completion: @escaping (Bool) -> Void)
    func isFavorited(movie: Movie, completion: @escaping (Bool) -> Void)
}

final class DetailViewModel: DetailVMInterface {
    private let firestoreManager: FirestoreManagerInterface
    
    //MARK: - Initializers
    init(firestoreManager: FirestoreManagerInterface = FirestoreManager.shared) {
        self.firestoreManager = firestoreManager
    }
    
    //MARK: - Favorites Functions
    func addToFavorites(movie: Movie, completion: @escaping (Bool) -> Void) {
        firestoreManager.addMovieToFavorite(movie: movie) {[weak self] in
            guard let self else { return }
            isFavorited(movie: movie) { bool in
                completion(bool)
            }
        } onError: { error in
            print(error)
        }
    }
    
    func removeFromFavorites(movie: Movie, completion: @escaping (Bool) -> Void) {
        firestoreManager.removeFromFavorites(movie: movie) {[weak self] in
            guard let self else { return }
            isFavorited(movie: movie) { bool in
                completion(bool)
            }
        } onError: { error in
            print(error)
        }
    }
    
    func isFavorited(movie: Movie, completion: @escaping (Bool) -> Void) {
        firestoreManager.isFavorited(movie: movie) { exists in
            completion(exists)
        } onError: { error in
            print(error)
        }
    }
    
    //MARK: - WatchList Functions
    func addToWatchList(movie: Movie, completion: @escaping (Bool) -> Void) {
        firestoreManager.addMovieToWatchList(movie: movie) {[weak self] in
            guard let self else { return }
            isFavorited(movie: movie) { bool in
                completion(bool)
            }
        } onError: { error in
            print(error)
        }
    }
    
    func removeFromWatchList(movie: Movie, completion: @escaping (Bool) -> Void) {
        firestoreManager.removeFromWatchList(movie: movie) {[weak self] in
            guard let self else { return }
            isFavorited(movie: movie) { bool in
                completion(bool)
            }
        } onError: { error in
            print(error)
        }
    }
    
    func isWatchList(movie: Movie, completion: @escaping (Bool) -> Void) {
        firestoreManager.isWatchList(movie: movie) { exists in
            completion(exists)
        } onError: { error in
            print(error)
        }
    }
}
