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
       imageView.tintColor = .label
        return imageView
    }()
    
    private lazy var emptyTitle: UILabel = {
        let label = UILabel()
    
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    //MARK: - Initializers
    init(image: UIImage?, title: String?) {
        super.init(frame: .zero)
        self.emptyImage.image = image
        self.emptyTitle.text = title
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        backgroundColor = .secondarySystemBackground
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
