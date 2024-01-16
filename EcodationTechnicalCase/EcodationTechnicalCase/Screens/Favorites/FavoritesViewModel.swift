//
//  FavoritesViewModel.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 16.01.2024.
//

import FirebaseFirestore
import FirebaseAuth

protocol FavoritesVMInterface {
    func viewDidLoad()
    func refreshUI()
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Movie
    func didSelectRowAt(at indexPath: IndexPath)
    func deleteSwipeAction(at indexPath: IndexPath)
}


final class FavoritesViewModel {
    //MARK: - Properties
    private weak var view: FavoritesVCInterface?
    private let firestoreManager: FirestoreManagerInterface
    private let currentUserID = Auth.auth().currentUser!.uid
    private var movies: [Movie] = []
    
    //MARK: - Initializers
    init(view: FavoritesVCInterface? = nil,
         firestoreManager: FirestoreManagerInterface = FirestoreManager.shared) {
        self.view = view
        self.firestoreManager = firestoreManager
    }
    
    func fetchFavorites(completion: @escaping([Movie]) -> Void) {
        firestoreManager.getMoviesFromFavorites {[weak self]
            favoriteMovies in
            guard self != nil else { return }
            
            completion(favoriteMovies)
        } onError: { error in
            print(error)
        }
    }
    
    
    func removeFromFavorites(movies: Movie) {
        firestoreManager.removeFromFavorites(movie: movies) {[weak self] in
            guard self != nil else { return }
            
         print("favorilerden çıkartılıyor...")
        } onError: { error in
            print(error)
        }
    }
}

// MARK: - FavoritesVMInterface
extension FavoritesViewModel: FavoritesVMInterface{
    func numberOfRowsInSection() -> Int {
        return movies.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Movie {
        let movie = movies[indexPath.row]
        return movie
    }
    
    func deleteSwipeAction(at indexPath: IndexPath) {
        let movies = movies[indexPath.row]
        removeFromFavorites(movies: movies)
        refreshUI()
    }
    
    func didSelectRowAt(at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let vc = DetailVC(movies: movie)
        view?.pushVC(vc: vc)
    }
    
    func viewDidLoad() {
        view?.configureViewDidLoad()
        refreshUI()
    }
    
    func refreshUI() {
        fetchFavorites { movies in
            self.movies = movies
            self.view?.tableViewReloadData()
        }
    }
}
