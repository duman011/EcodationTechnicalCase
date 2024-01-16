//
//  WatchListViewModel.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 16.01.2024.
//

import FirebaseFirestore
import FirebaseAuth

protocol WatchListVMInterface {
    func viewDidLoad()
    func refreshUI()
    func numberOfRowsInSection() -> Int
    func cellForRow(at indexPath: IndexPath) -> Movie
    func didSelectRowAt(at indexPath: IndexPath)
    func deleteSwipeAction(at indexPath: IndexPath)
}


final class WatchListViewModel {
    //MARK: - Properties
    private weak var view: WatchListVCInterface?
    private let firestoreManager: FirestoreManagerInterface
    private var movies: [Movie] = []
    
    //MARK: - Initializers
    init(view: WatchListVCInterface? = nil,
         firestoreManager: FirestoreManagerInterface = FirestoreManager.shared) {
        self.view = view
        self.firestoreManager = firestoreManager
    }
    
    func fetchFavorites(completion: @escaping([Movie]) -> Void) {
        firestoreManager.getMoviesFromFavorites {[weak self]
            favoriteMovies in
            guard let self else { return }
            
            completion(favoriteMovies)
        } onError: { error in
            print(error)
        }
    }
    
    func removeFromFavorites(movies: Movie) {
            firestoreManager.removeFromFavorites(movie: movies) {[weak self] in
                guard let self else { return }
                
             print("favorilerden çıkartılıyor...")
            } onError: { error in
                print(error)
            }
    }
}

// MARK: - WatchListVMInterface
extension WatchListViewModel: WatchListVMInterface{
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
