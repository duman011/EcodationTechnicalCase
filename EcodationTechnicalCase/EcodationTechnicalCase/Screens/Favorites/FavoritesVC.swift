//
//  FavoritesVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

protocol FavoritesVCInterface: AnyObject{
    func configureViewDidLoad()
    func tableViewReloadData()
    func pushVC(vc: UIViewController)
}

final class FavoritesVC: UIViewController {

    //MARK: - Properties
    private let favoriteView = FavoritesView()
    private lazy var viewModel = FavoritesViewModel(view: self)
    private lazy var emptyView = EmptyListView(image:  UIImage(systemName: "popcorn.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 130)),
                                               title: "Your favorite movies list is currently empty")
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshUI()
    }

    // MARK: - LoadView
    override func loadView() {
        super.loadView()
        view = favoriteView
    }

    // MARK: - UI Configuration
    private func configureNavbar() {
        navigationItem.title = "Favorites List"
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureTableView(){
        favoriteView.tableView.delegate = self
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.backgroundColor = .secondarySystemBackground
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension FavoritesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numberOfRowsInSection() == 0 {
            tableView.backgroundView = emptyView
        } else {
            tableView.backgroundView = UIView()
        }
        
        return viewModel.numberOfRowsInSection()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = viewModel.cellForRow(at: indexPath)
        cell.configure(with: movie)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRowAt(at: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    // MARK: - Delete Swipe Action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            self.viewModel.deleteSwipeAction(at: indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - FavoritesVCInterface
// FavoritesVCInterface protokolünü uygulayan metotlar.
extension FavoritesVC: FavoritesVCInterface{
    func pushVC(vc: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableViewReloadData() {
        favoriteView.tableView.reloadData()
    }
    
    func configureViewDidLoad() {
        configureNavbar()
        configureTableView()
    }
    
 
}
