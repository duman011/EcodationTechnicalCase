//
//  EmptyListView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import UIKit

final class EmptyListView: UIView {
    
    //MARK: - Properties
   private lazy var emptyImage: UIImageView = {
        let imageView = UIImageView()
       imageView.image = UIImage(systemName: "movieclapper")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 130))
        return imageView
    }()
    
    private lazy var emptyTitle: UILabel = {
        let label = UILabel()
        label.text = "No movies found for the given search text."
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
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
        addSubviewsExt(emptyImage, emptyTitle)
        configureEmptyImage()
        configureEmptyTitle()
    }
    
    private func configureEmptyImage() {
        emptyImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyImage.bottomAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configureEmptyTitle() {
        emptyTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyTitle.topAnchor.constraint(equalTo: emptyImage.bottomAnchor),
            emptyTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            emptyTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 10)
        ])
    }
}
