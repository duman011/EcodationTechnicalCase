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
    func removeFromFavorites(movies: Movie)
}


final class FavoritesViewModel {
    //MARK: - Properties
    private weak var view: FavoritesVCInterface?
    private let firestoreManager: FirestoreManagerInterface
    var movies: [Movie] = []
    
    //MARK: - Initializers
    init(view: FavoritesVCInterface? = nil,
         firestoreManager: FirestoreManagerInterface = FirestoreManager.shared) {
        self.view = view
        self.firestoreManager = firestoreManager
    }
    
    private func fetchFavorites(completion: @escaping([Movie]) -> Void) {
        firestoreManager.getMoviesFromFavorites { favoriteMovies in
            completion(favoriteMovies)
        } onError: { error in
            print(error)
        }
    }
}

// MARK: - FavoritesVMInterface
// FavoritesVMInterface protokolünü uygulayan metotlar.
extension FavoritesViewModel: FavoritesVMInterface{
    
    /// Cell sayısını döndüren metot.
    func numberOfRowsInSection() -> Int {
        return movies.count
    }
    
    /// Belirtilen indexPath'deki hücreyi döndüren metot.
    func cellForRow(at indexPath: IndexPath) -> Movie {
        let movie = movies[indexPath.row]
        return movie
    }
    
    /// Belirtilen indexPath'deki hücreye yapılan kaydırma işlemi sonrasında tetiklenen metot.
    func deleteSwipeAction(at indexPath: IndexPath) {
        let movies = movies[indexPath.row]
        removeFromFavorites(movies: movies)
        refreshUI()
    }
    
    /// Belirtilen indexPath'deki hücreye tıklanma olayını işleyen metot.
    func didSelectRowAt(at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let vc = DetailVC(movies: movie)
        view?.pushVC(vc: vc)
    }
    
    /// ViewDidLoad olayını işleyen metot.
    func viewDidLoad() {
        view?.configureNavbar()
        view?.prepareTableView()
        refreshUI()
    }
    
    /// Arayüzü yenileyen metot.
    func refreshUI() {
        fetchFavorites { movies in
            self.movies = movies
            self.view?.tableViewReloadData()
        }
    }
    
    /// Filmi Favoriden çıkarma işlemini gerçekleştiren metot.
    func removeFromFavorites(movies: Movie) {
        firestoreManager.removeFromFavorites(movie: movies) {
         print("favorilerden çıkartılıyor...")
        } onError: { error in
            print(error)
        }
    }
}
