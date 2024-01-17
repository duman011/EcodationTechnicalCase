//
//  DetailVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import UIKit
import SDWebImage

final class DetailVC: UIViewController {
    
    //MARK: - Properties
    private lazy var viewModel = DetailViewModel()
    private let detailView = DetailView()
    private lazy var isFavorited = false
    private lazy var isWatchList = false
    var movies: Movie? = nil
    
    
    //MARK: - Initializers
    init(movies: Movie? = nil) {
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.delegate = self
        configureUI()
    }
    
    // MARK: - LoadView
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        updateUI()
        configureNavBar()
        configureFavoriteAndWatchListButton()
    }
    
    // MARK: - NavBar Configuration
    private func configureNavBar() {
        navigationItem.rightBarButtonItems = [detailView.favoriteButton,
                                              detailView.watchListButton]
    }
    
    // MARK: - Update UI with Movie Data
    private func updateUI() {
        
        if let imageURL = movies?.backdrop_path ?? movies?.poster_path{
            detailView.movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/"+imageURL))
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
    
    
    // MARK: - Configure Favorite and WatchList Buttons
    private func configureFavoriteAndWatchListButton() {
      // Configure isFavorite button
        viewModel.isFavorited(movie: movies!) { bool in
             self.isFavorited = bool
            self.detailView.favoriteButton.image = UIImage(systemName: bool ? "suit.heart.fill" : "suit.heart")
         }
        
        // Configure isWatchList button
        viewModel.isWatchList(movie: movies!) { bool in
            self.isWatchList = bool
            self.detailView.watchListButton.image = UIImage(systemName: bool ? "text.badge.minus" : "text.badge.plus")
        }
     }
}

// MARK: - DetailViewProtocol
extension DetailVC: DetailViewProtocol {
    
    // MARK: - WatchList Button Tapped
    func watchListButtonTapped() {
        if isWatchList {
            viewModel.removeFromWatchList(movie: movies!) { bool in
                self.isWatchList = bool
                self.detailView.watchListButton.image = UIImage(systemName: "text.badge.plus")
            }
        } else {
            viewModel.addToWatchList(movie: movies!) { bool in
                self.isWatchList = bool
                self.detailView.watchListButton.image = UIImage(systemName: "text.badge.minus")
            }
        }
    }
    
    // MARK: - Favorites Button Tapped
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
