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
}


final class SearchViewModel {
    private weak var view: SearcVCInterface?
    private lazy var workItem = WorkItem()
    private let networkService: NetworkServiceInterface
    
    var movies: [Movie] = [Movie]()
    
    init(view: SearcVCInterface?,
         networkService: NetworkServiceInterface = NetworkService.shared) {
        self.view = view
        self.networkService = networkService
    }
    
    
    func updateSearchResults(searchText: String) {
        workItem.perform(after: 0.5) { [weak self] in
            guard let self else { return }
            if searchText.isEmpty {
              //
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
    func viewDidLoad() {
        view?.configureViewDidload()
    }
    
    func movieDidSelectItem(at indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let vc = DetailVC(movies: movie)
        view?.pushVC(vc: vc)
    }
    
}

