//
//  GenreTableViewCell.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import UIKit

class GenreTableViewCell: UITableViewCell {
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var genreText: String? {
        didSet {
           setupNameLabel()
        }
    }
}

extension GenreTableViewCell {
    private func setupNameLabel() {
        genreLabel.text = genreText
        contentView.addSubview(genreLabel)
        genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        genreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        genreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
}
