//
//  SearchVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

protocol SearcVCInterface: AnyObject {
    func configureViewDidload()
    func searchTableViewReloadData()
    func pushVC(vc: UIViewController)
}

final class SearchVC: UIViewController {

    //MARK: - Properties
    private lazy var viewModel = SearchViewModel(view: self)
    private let searchView = SearchView()
    private let emptyView = EmptyListView()
  
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Load View
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    // MARK: - UI Configuration
    private func prepareSearchTableView() {
        searchView.searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchView.searchTableView.dataSource = self
        searchView.searchTableView.delegate = self
     }
    
    private func configureNavigationBar() {
        navigationItem.title = "Movie Search"
        searchView.searchController.searchResultsUpdater = self
        navigationItem.searchController = searchView.searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
}

// MARK: - UISearchResultsUpdating
extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        viewModel.updateSearchResults(searchText: searchText)
    }
}

// MARK: - UITableViewDataSource && UITableViewDelegate
extension SearchVC: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.movies.count == 0 {
            tableView.backgroundView = emptyView
        }
        
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

         // Kontrol ekleyerek index out of range hatasını önle
         guard indexPath.row < viewModel.movies.count  else {
             return cell
         }

        let movie = viewModel.movies[indexPath.row]
         cell.textLabel?.text = movie.original_title
         return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.movieDidSelectItem(at: indexPath)
    }
}
    
// MARK: - SearcVCInterface
extension SearchVC: SearcVCInterface {
    func configureViewDidload() {
        configureNavigationBar()
        prepareSearchTableView()
    }
    
    func searchTableViewReloadData() {
        DispatchQueue.main.async {
            self.searchView.searchTableView.reloadData()
        }
    }
    
    func pushVC(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

