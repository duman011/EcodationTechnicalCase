//
//  SearchViewModel.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import Foundation

protocol SearchVMInterface{
    func viewDidLoad()
    func movieDidSelectItem(at indexPath: IndexPath)
    func logout(completion: @escaping () -> Void)
}


final class SearchViewModel {
    //MARK: - Properties
    private weak var view: SearcVCInterface?
    private lazy var workItem = WorkItem()
    private let networkService: NetworkServiceInterface
    
    var movies: [Movie] = [Movie]()
    
    //MARK: - Initializers
    init(view: SearcVCInterface?,
         networkService: NetworkServiceInterface = NetworkService.shared) {
        self.view = view
        self.networkService = networkService
    }
    
    // MARK: - UpdateSearchResults
    ///workItem nesnesi sayesine 0.5sn lik bir gecikme verdikten sonra netwoke istek atıyoruz (her harfte istek atmaması için)
    func updateSearchResults(searchText: String) {
        workItem.perform(after: 0.5) { [weak self] in
            guard let self else { return }
            if searchText.isEmpty {
                movies.removeAll()
                self.view?.searchTableViewReloadData()
            } else {
                Task{
                    do {
                        let getUpcomingMovies  = try await self.networkService.search(with: searchText).results.filter({$0.poster_path != nil})
                        self.movies = getUpcomingMovies
                        self.view?.searchTableViewReloadData()
                        
                    }catch {
                        if let movieError = error as? MovieError {
                            print(movieError.rawValue)
                        } else {
                            
                        }
                    }
                }
            }
        }
    }
}

extension SearchViewModel: SearchVMInterface{
    func logout(completion: @escaping () -> Void) {
        FirebaseAuthManager.shared.signOut {
            print("Logout ...")
            completion()
        } onError: { error in
            print("Logout Error: \(error.localizedDescription)")
        }
    }
    
    func viewDidLoad() {
        view?.configureViewDidload()
    }
    
    func movieDidSelectItem(at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let vc = DetailVC(movies: movie)
        view?.pushVC(vc: vc)
    }
}

