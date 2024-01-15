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
    private weak var view: FavoritesVCInterface?
    private let currentUserID = Auth.auth().currentUser!.uid
    private var movies: [Movie] = []
    
    
    init(view: FavoritesVCInterface? = nil) {
        self.view = view
    }
    
    func fetchFavorites(completion: @escaping([Movie]) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                let movies = documents.compactMap({try? $0.data(as: Movie.self)})
                completion(movies)
            }
    }
    
    
    
    func removeFromFavorites(movies: Movie) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(String(movies.id))
            .delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
    
    
}

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
