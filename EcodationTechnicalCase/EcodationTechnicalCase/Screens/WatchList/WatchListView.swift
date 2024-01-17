//
//  WatchListView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 16.01.2024.
//

import UIKit

final class WatchListView: UIView {
    //MARK: - Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
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
        configureFavoriteTableView()
    }
    
    private func configureFavoriteTableView() {
        addSubview(tableView)
        // UITableView Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
