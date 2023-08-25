//
//  MovieListTableViewCell.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import UIKit
import Combine

class MovieListTableViewCell: UITableViewCell {

    private let movieImageView: ImageLoader = {
        let img = ImageLoader()
        img.backgroundColor = .placeholderText
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
     }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .black
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movie: Result? {
        didSet {
            bindView()
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListTableViewCell {
    private func setupView() {
        contentView.addSubview(movieImageView)
        movieImageView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor, constant: 0).isActive = true
        movieTitleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        contentView.addSubview(releaseLabel)
        releaseLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16).isActive = true
        releaseLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8).isActive = true
        releaseLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: movieImageView.bottomAnchor, constant: -8).isActive = true
        descriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    private func bindView() {
        if let path = movie?.posterPath {
            movieImageView.loadImageWithUrl(path)
        } else {
            
        }
        
        movieTitleLabel.text = movie?.title
        releaseLabel.text = movie?.releaseDate
        descriptionLabel.text = movie?.overview
        layoutIfNeeded()
    }
}
