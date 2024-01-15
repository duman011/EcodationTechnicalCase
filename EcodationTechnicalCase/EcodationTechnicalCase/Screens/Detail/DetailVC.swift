//
//  DetailVC.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 15.01.2024.
//

import UIKit

final class DetailVC: UIViewController {

    //MARK: - Properties
    private let detailView = DetailView()
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
    override func loadView() {
        super.loadView()
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    // MARK: - Data Update
    private func updateUI() {
     
        if let imageURL = movies?.poster_path {
            detailView.movieImage.downloadSetImage(url:"https://image.tmdb.org/t/p/w500/"+imageURL)
        }
        
    }

}
