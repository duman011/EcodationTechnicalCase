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
    
    /// Firestore'dan kullanıcının izlenecekler Listesindeki filmleri çeker.
    func fetchWatchList(completion: @escaping([Movie]) -> Void) {
        firestoreManager.getMoviesFromWatchList {watchListMovies in
            completion(watchListMovies)
        } onError: { error in
            print(error)
        }
    }
    
    /// İzleme listesinden bir filmi kaldırır.
    func removeMovieFromWatchList(movies: Movie) {
        firestoreManager.removeFromWatchList(movie: movies) {
            print("WatchList'den çıkartılıyor...")
        } onError: { error in
            print(error)
        }
    }
}

// MARK: - WatchListVMInterface
extension WatchListViewModel: WatchListVMInterface{
    /// İzleme listesindeki toplam film sayısını döndürür.
    func numberOfRowsInSection() -> Int {
        return movies.count
    }
    
    /// Belirtilen indexPath için filmi döndürür.
    func cellForRow(at indexPath: IndexPath) -> Movie {
        let movie = movies[indexPath.row]
        return movie
    }
    
    func deleteSwipeAction(at indexPath: IndexPath) {
        let movies = movies[indexPath.row]
        removeMovieFromWatchList(movies: movies)
        refreshUI()
    }
    
    /// Belirtilen indexPath'deki filmi seçtiğinde çağrılır ve film detaylarına gider.
    func didSelectRowAt(at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let vc = DetailVC(movies: movie)
        view?.pushVC(vc: vc)
    }
    
    /// View Controller yüklendiğinde çağrılır ve gerekli konfigürasyonları yapar.
    func viewDidLoad() {
        view?.configureViewDidLoad()
        refreshUI()
    }
    
    // Filmleri güncelleyerek TableView'i yeniden yükler.
    func refreshUI() {
        fetchWatchList { movies in
            self.movies = movies
            self.view?.tableViewReloadData()
        }
    }
}
