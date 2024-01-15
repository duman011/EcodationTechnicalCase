//
//  SearchVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

final class SearchVC: UIViewController {

    //MARK: - Properties
    private let searchView = SearchView()
    // MARK: - Properties
    public var movies: [Movie] = [Movie]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        prepareSearchTableView()
        
    }
    
    // MARK: - Load View
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    func prepareSearchTableView() {
        searchView.searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchView.searchTableView.dataSource = self
        searchView.searchTableView.delegate = self
     }
    
    func configureNavigationBar() {
        navigationItem.title = "Song Search"
        searchView.searchController.searchResultsUpdater = self
        navigationItem.searchController = searchView.searchController
    }
    
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        Task{
            do {
                let getUpcomingMovies  = try await APICaller.shared.search(with: searchText).results.filter({$0.poster_path != nil})
                self.movies = getUpcomingMovies
                searchView.searchTableView.reloadData()
               
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                   
                }
            }
        }
    }
}

extension SearchVC: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

         // Kontrol ekleyerek index out of range hatasını önle
         guard indexPath.row < movies.count else {
             return cell
         }

         let movie = movies[indexPath.row]
         cell.textLabel?.text = movie.original_title
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailVC(movies: movies[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }   
}
    

