//
//  SearchVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

protocol SearcVCInterface: AnyObject {
    func configureNavigationBar()
    func prepareSearchTableView()
    func searchTableViewReloadData()
    func pushVC(vc: UIViewController)
}

final class SearchVC: UIViewController {
    
    //MARK: - Properties
    private lazy var viewModel = SearchViewModel(view: self)
    private let searchView = SearchView()
    private let emptyView = EmptyListView(image:  UIImage(systemName: "movieclapper")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 130)),
                                          title: "No movies found for the given search text.")
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
        checkNetworkConnection()
    }
    
    // MARK: - Load View
    override func loadView() {
        super.loadView()
        view = searchView
    }
    
    /// Internet baglantisi olmadigi durumlarda bir alert cikarir.
    private func checkNetworkConnection() {
        if Reachability.isNetworkAvailable() {
            viewModel.viewDidLoad()
        } else {
            self.presentAlert(title: "Hata", message: "Lütfen internet bağlantınızı kontrol ediniz.", buttonTitle: "OK")
        }
    }
    
    // MARK: - UI Configuration
    /// Arayuzdeki degisiklikleri ayarlar.
    internal func prepareSearchTableView() {
        searchView.searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchView.searchTableView.dataSource = self
        searchView.searchTableView.delegate = self
    }
    
    internal func configureNavigationBar() {
        navigationItem.title = "Movie Search"
        searchView.searchController.searchResultsUpdater = self
        navigationItem.searchController = searchView.searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.rightBarButtonItems = [searchView.logoutButton]
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
        }else {
            tableView.backgroundView = UIView()
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
// SearcVCInterface protokolünü uygulayan metotlar.
extension SearchVC: SearcVCInterface {
    func searchTableViewReloadData() {
        DispatchQueue.main.async {
            self.searchView.searchTableView.reloadData()
        }
    }
    
    func pushVC(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - SearchViewProtocol
// SearchViewProtocol protokolünü uygulayan metot.
extension SearchVC: SearchViewProtocol{
    func logoutButtonTapped() {
        viewModel.logout{
            let loginVC = LoginVC()
            let nav = UINavigationController(rootViewController: loginVC)
            self.view.window?.rootViewController = nav
        }
    }
}
