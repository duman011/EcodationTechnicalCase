//
//  DetailView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import UIKit

final class DetailView: UIView {
    
    //MARK: - Properties
    lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var movieName: UILabel = {
        let label = UILabel()
        label.text = "movie Name"
        return label
    }()
    
    // Stack View for IMDb Rating
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imdbImageView,
                                                      imdbLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    // IMDb Rating Label
    lazy var imdbLabel: UILabel = {
        let label = UILabel()
        label.text = "8.7"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 25,weight: .bold)
        return label
    }()
    
    // IMDb Star Icon
    private lazy var imdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.yellow
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieReleaseDate,
                                                      releaseDateImage])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var movieReleaseDate: UILabel = {
       let label = UILabel()
        label.text = "2023-09-13"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var releaseDateImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar.badge.clock")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .label
        return image
    }()
    
    lazy var movieOverview: UILabel = {
        let label = UILabel()
        label.text = "test movie overview.."
        label.numberOfLines = 0
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
    
    //MARK: - UI Configuration
    private func configureUI() {
        addSubviewsExt(movieImage)
        configureMovieImage()
    }
    
    private func configureMovieImage() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
 

}
