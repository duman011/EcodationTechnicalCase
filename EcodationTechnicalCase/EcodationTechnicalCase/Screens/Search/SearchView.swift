//
//  SearchView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 13.01.2024.
//


import UIKit

final class SearchView: UIView {
    
    //MARK: - Properties
    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    
    private func configureUI() {
        backgroundColor = .secondarySystemBackground
        configureResultsCollectionView()
    }
    
    private func configureResultsCollectionView() {
        addSubview(searchTableView)
        
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    } 
}
