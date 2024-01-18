//
//  WatchListVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//

import UIKit

protocol WatchListVCInterface: AnyObject{
    func configureNavbar()
    func prepareTableView()
    func tableViewReloadData()
    func pushVC(vc: UIViewController)
}

final class WatchListVC: UIViewController {

    //MARK: - Properties
    private let watchListView = WatchListView()
    private lazy var viewModel = WatchListViewModel(view: self)
    private lazy var emptyView = EmptyListView(image:  UIImage(systemName: "list.and.film"),title: "Your movie list is currently empty.")
    
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
        view = watchListView
    }
}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension WatchListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.numberOfRowsInSection() == 0 {
            tableView.backgroundView = emptyView
        }else {
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
        
        let watchListTableViewHeight: CGFloat = DeviceTypes.is_iPhoneSE || DeviceTypes.is_iPhone8Zoomed ? 120 : 150
        
        return watchListTableViewHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            self.viewModel.deleteSwipeAction(at: indexPath)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - WatchListVCInterface
// WatchListVCInterface protokolünü uygulayan metotlar.
extension WatchListVC: WatchListVCInterface{
    
    func pushVC(vc: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableViewReloadData() {
        watchListView.tableView.reloadData()
    }    

     func configureNavbar() {
         let titleLabel = UILabel()
         titleLabel.text = "Watch List"
         
         if let customFont = UIFont(name: "Agbalumo-Regular", size: 30) {
             titleLabel.font = customFont
             self.navigationItem.titleView = titleLabel
             titleLabel.textColor = .label
         }
        view.backgroundColor = .secondarySystemBackground
    }
    
     func prepareTableView(){
        watchListView.tableView.delegate = self
        watchListView.tableView.dataSource = self
        watchListView.tableView.backgroundColor = .secondarySystemBackground
    }
}
