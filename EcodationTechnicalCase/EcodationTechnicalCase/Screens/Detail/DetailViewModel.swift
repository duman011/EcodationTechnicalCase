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
    //MARK: - Properties
    private let firestoreManager: FirestoreManagerInterface
    
    //MARK: - Initializers
    init(firestoreManager: FirestoreManagerInterface = FirestoreManager.shared) {
        self.firestoreManager = firestoreManager
    }
    
    //MARK: - Favorites Functions
    
    /// Favorilere ekleme işlemini gerçekleştirir.
    /// - Parameters:
    ///   - movie: Eklenecek film.
    ///   - completion: İşlem tamamlandığında çağrılacak closure.
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
    
    /// Favorilerden kaldırma işlemini gerçekleştirir.
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
    
    /// Bir film favori listesinde mi kontrolünü gerçekleştirir.
    func isFavorited(movie: Movie, completion: @escaping (Bool) -> Void) {
        firestoreManager.isFavorited(movie: movie) { exists in
            completion(exists)
        } onError: { error in
            print(error)
        }
    }
    
    
    //MARK: - WatchList Functions
    
    /// İzleme listesine ekleme işlemini gerçekleştirir.
    /// - Parameters:
    ///   - movie: Eklenecek film.
    ///   - completion: İşlem tamamlandığında çağrılacak closure.
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
    
    /// İzleme listesinden kaldırma işlemini gerçekleştirir.
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
    
    /// Bir film izleme listesinde mi kontrolünü gerçekleştirir.
    func isWatchList(movie: Movie, completion: @escaping (Bool) -> Void) {
        firestoreManager.isWatchList(movie: movie) { exists in
            completion(exists)
        } onError: { error in
            print(error)
        }
    }
}
