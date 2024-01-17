//
//  DetailView.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import UIKit
// MARK: - Login View Protocol
protocol DetailViewProtocol: AnyObject {
    func watchListButtonTapped()
    func favoritesButtonTapped()
}
final class DetailView: UIView {
    
    //MARK: - Properties
    weak var delegate: DetailViewProtocol?
    
    lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var movieName: UILabel = {
        let label = UILabel()
        label.text = "movie Name"
        label.font = UIFont.systemFont(ofSize: 22,weight: .bold)
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
        label.font = UIFont.systemFont(ofSize: 18,weight: .bold)
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
    
    lazy var movieOverview: UITextView = {
        let textView = UITextView()
        textView.text = "test movie overview.."
        textView.backgroundColor = .secondarySystemBackground
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    lazy var watchListButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "text.badge.minus"), style: UIBarButtonItem.Style.done, target: self, action: #selector(watchListButtonTapped))
        return button
    }()
    
    lazy var favoriteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "suit.heart"), style: UIBarButtonItem.Style.done, target: self, action: #selector(favoritesButtonTapped))
        return button
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
        backgroundColor = .secondarySystemBackground
        addSubviewsExt(movieImage, movieName, dateStackView, movieOverview)
        configureMovieImage()
        configureRatingStackView()
        configureMovieName()
        configureDateStackView()
        configureMovieOverview()
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
    
    private func configureRatingStackView() {
        movieImage.addSubview(ratingStackView)
        ratingStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingStackView.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -5),
            ratingStackView.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 10)
        ])
    }
    
    private func configureMovieName() {
        movieName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieName.bottomAnchor.constraint(equalTo: ratingStackView.topAnchor, constant: -5),
            movieName.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 10)
        ])
    }
 
    private func configureDateStackView() {
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateStackView.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -5),
            dateStackView.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureMovieOverview() {
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieOverview.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10),
            movieOverview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            movieOverview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            movieOverview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - @Actions
    @objc private func watchListButtonTapped() {
        delegate?.watchListButtonTapped()
    }
    
    @objc private func favoritesButtonTapped() {
        delegate?.favoritesButtonTapped()
    }
}
