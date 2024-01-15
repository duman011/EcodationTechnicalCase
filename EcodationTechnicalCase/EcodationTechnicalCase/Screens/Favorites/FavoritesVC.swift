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
    private lazy var viewModel: FavoritesViewModel? = FavoritesViewModel(view: self)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.refreshUI()
    }

    override func loadView() {
        super.loadView()
        view = favoriteView
    }

    // MARK: - UI Configuration
    private func configureTableView(){
        favoriteView.tableView.delegate = self
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.backgroundColor = .secondarySystemBackground
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension FavoritesVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        if let movie = viewModel?.cellForRow(at: indexPath) {
            cell.configure(with: movie)
        }
   
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectRowAt(at: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            self.viewModel?.deleteSwipeAction(at: indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - FavoritesVCInterface
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
        navigationController?.navigationBar.tintColor = UIColor.red
        view.backgroundColor = .secondarySystemBackground
        configureTableView()
    }
}
