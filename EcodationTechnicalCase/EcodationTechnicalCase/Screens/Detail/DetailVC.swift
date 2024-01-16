//
//  DetailVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import UIKit

final class DetailVC: UIViewController {
    
    //MARK: - Properties
    private lazy var viewModel = DetailViewModel()
    private let detailView = DetailView()
    var movies: Movie? = nil
    private lazy var isFavorited = false
    private lazy var isWatchList = false
    
    
    //MARK: - Initializers
    init(movies: Movie? = nil) {
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.delegate = self
        updateUI()
        configureNavBar()
        configureFavoriteButton()
    }
    
    // MARK: - UI Configuration
    private func configureNavBar() {
        navigationItem.rightBarButtonItems = [detailView.favoriteButton,
                                              detailView.watchListButton]
    }
    
    // MARK: - Data Update
    private func updateUI() {
        
        if let imageURL = movies?.poster_path {
            detailView.movieImage.downloadSetImage(url:"https://image.tmdb.org/t/p/w500/"+imageURL)
        }
        
        if let movieName = movies?.original_title {
            detailView.movieName.text = movieName
        }
        
        
        if let movieRating = movies?.vote_average {
            let formattedValue = String(format: "%.1f", movieRating)
            detailView.imdbLabel.text = formattedValue
        }
        
        if let movieReleaseDate = movies?.release_date {
            detailView.movieReleaseDate.text = movieReleaseDate
        }
       
        if let movieOverview = movies?.overview {
            detailView.movieOverview.text = movieOverview
        }
    }
    
    private func configureFavoriteButton() {
        // MARK: - isFavorite Button Configure
        viewModel.isFavorited(movie: movies!) { bool in
             self.isFavorited = bool
            self.detailView.favoriteButton.image = UIImage(systemName: bool ? "suit.heart.fill" : "suit.heart")
         }
        // MARK: - isWatchList Button Configure
        viewModel.isWatchList(movie: movies!) { bool in
            self.isWatchList = bool
            self.detailView.watchListButton.image = UIImage(systemName: bool ? "text.badge.plus" : "text.badge.minus")
        }
     }
    
}

extension DetailVC: DetailViewProtocol {
    func watchListButtonTapped() {
        if isWatchList {
            viewModel.removeFromWatchList(movie: movies!) { bool in
                self.isFavorited = bool
                self.detailView.watchListButton.image = UIImage(systemName: "text.badge.minus")
            }
        } else {
            viewModel.addToWatchList(movie: movies!) { bool in
                self.isWatchList = bool
                self.detailView.watchListButton.image = UIImage(systemName: "text.badge.plus")
            }
        }
    }
    
    func favoritesButtonTapped() {
        if isFavorited {
            viewModel.removeFromFavorites(movie: movies!) { bool in
                self.isFavorited = bool
                self.detailView.favoriteButton.image = UIImage(systemName: "suit.heart")
            }
        } else {
            viewModel.addToFavorites(movie: movies!) { bool in
                self.isFavorited = bool
                self.detailView.favoriteButton.image = UIImage(systemName: "suit.heart.fill")
            }
        }
    }
}
