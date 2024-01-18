//
//  MovieTableViewCell.swift
//  EcodationTechnicalCase
//
//  Created by Yaşar Duman on 16.01.2024.
//

import UIKit
import SDWebImage

final class MovieTableViewCell: UITableViewCell {

    //MARK: - Cell's Identifier
    static let identifier = "MovieTableViewCell"
    
    
    //MARK: - UI Elements
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 15
        container.layer.shadowColor = UIColor.label.cgColor
        container.layer.shadowOffset = CGSize(width: 0, height: 0)
        container.layer.shadowOpacity = 0.6
        container.layer.shadowRadius = 4
        container.layer.masksToBounds = false
        return container
    }()
    
   private lazy var titleStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                      playTitleButton])
       stackView.axis = .horizontal
       stackView.spacing = 8
       stackView.alignment = .center
       return stackView
   }()
   
   lazy var titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Başlık glecek Inanıyorum"
       label.lineBreakMode = .byTruncatingTail
       label.numberOfLines = 1
       return label
   }()
   
   private let playTitleButton: UIButton = {
       let button = UIButton()
       let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35))
       button.setImage(image, for: .normal)
       button.tintColor = .label
       return button
   }()
   
 
   
   lazy var titlesPosterUIImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       imageView.layer.masksToBounds = true
       imageView.layer.maskedCorners = [
           .layerMinXMinYCorner,
           .layerMinXMaxYCorner
       ]
       imageView.layer.cornerRadius = 15
       return imageView
   }()
   
   private lazy var dateStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [releaseDateImage,
                                                      movieReleaseDate])
       stackView.axis = .horizontal
       stackView.spacing = 8
       stackView.alignment = .center
       return stackView
   }()
   
   lazy var movieReleaseDate: UILabel = {
      let label = UILabel()
       label.text = "2023-09-13"
       label.textColor = .secondaryLabel
       return label
   }()
   
   private lazy var releaseDateImage: UIImageView = {
       let image = UIImageView()
       image.image = UIImage(systemName: "calendar.badge.clock")
       image.contentMode = .scaleAspectFill
       image.clipsToBounds = true
       image.tintColor = .label
       return image
   }()
   
   private lazy var imdbStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [imdbLabel,
                                                      imdbImageView])
       stackView.axis = .horizontal
       stackView.spacing = 8
       stackView.alignment = .center
       return stackView
   }()
   
   lazy var imdbLabel: UILabel = {
       let label = UILabel()
       label.text = "8.7"
       label.textColor = .label
       label.font = UIFont.systemFont(ofSize: 15,weight: .bold)
       return label
   }()
   
   private lazy var imdbImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFit
       imageView.clipsToBounds = true
       imageView.tintColor = UIColor.yellow
       imageView.image = UIImage(systemName: "star.fill")
       return imageView
   }()
   
   // MARK: - Initializers
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       backgroundColor = .secondarySystemBackground
       selectionStyle = .none
       
       contentView.addSubview(containerView)
       containerView.addSubviewsExt(titlesPosterUIImageView,titleStackView,dateStackView,imdbStackView)
       configureUI()
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.shadowColor = UIColor.label.cgColor
    }
    

   // MARK: - UI Configuration
    private func configureUI() {
        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])

        // Title Poster UIImageView Constraints
        titlesPosterUIImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titlesPosterUIImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ])

        // Title StackView Constraints
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleStackViewTopConstant: CGFloat = DeviceTypes.is_iPhoneSE || DeviceTypes.is_iPhone8Zoomed ? 18: 25
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: titleStackViewTopConstant),
            titleStackView.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
        
        // Title Label Constraints
        let titleLabelFont: CGFloat = DeviceTypes.is_iPhoneSE || DeviceTypes.is_iPhone8Zoomed ? 15 : 16
        
        titleLabel.font = UIFont.systemFont(ofSize: titleLabelFont, weight: .medium)

        // Play Title Button Constraints
        playTitleButton.translatesAutoresizingMaskIntoConstraints = false
        
        let playTitleButtonHeightConstant: CGFloat = DeviceTypes.is_iPhoneSE || DeviceTypes.is_iPhone8Zoomed ? 25 : 35
        
        NSLayoutConstraint.activate([
            playTitleButton.widthAnchor.constraint(equalToConstant: playTitleButtonHeightConstant),
            playTitleButton.heightAnchor.constraint(equalToConstant: playTitleButtonHeightConstant)
        ])

        // Date StackView Constraints
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
        ])
        
        // Date Constraints
        let movieReleaseDateFont: CGFloat = DeviceTypes.is_iPhoneSE || DeviceTypes.is_iPhone8Zoomed ? 14 : 16
        
        movieReleaseDate.font = UIFont.systemFont(ofSize: movieReleaseDateFont, weight: .medium)
        
        releaseDateImage.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: movieReleaseDateFont)

        // IMDB StackView Constraints
        imdbStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let imdbLabelFont: CGFloat = DeviceTypes.is_iPhoneSE || DeviceTypes.is_iPhone8Zoomed ? 14 : 16
        
        imdbLabel.font = UIFont.systemFont(ofSize: imdbLabelFont, weight: .medium)
        
        imdbImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: imdbLabelFont)
        
        NSLayoutConstraint.activate([
            imdbStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            imdbStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: - Public Methods
    func configure(with movies: Movie) { 
        if let imageURL = movies.poster_path {
            titlesPosterUIImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(imageURL)"))
        }
        
        titleLabel.text = movies.original_title
        movieReleaseDate.text = movies.release_date
        
        if let voteAverage = movies.vote_average {
            let formattedValue = String(format: "%.1f", voteAverage)
            self.imdbLabel.text = formattedValue
        }
    }
}
