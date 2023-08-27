//
//  RatingComponent.swift
//  TMDB-Viper
//
//  Created by Icung on 26/08/23.
//

import UIKit

class RatingComponent: UIView {
    
    private lazy var ratingLabel = UILabel()
    private lazy var stackView = UIStackView()
    
    var rating: Double? {
        didSet {
            guard let rating = rating else {
                return
            }
            
            bindData(rating: rating)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
}

extension RatingComponent {
    private func setupView() {
        addSubview(ratingLabel)
        ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.textColor = .orange
        ratingLabel.applyStyle(size: 16, color: .orange, isBold: true)
        
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 8).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.fillEqually
    }
    
    private func bindData(rating: Double) {
        stackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
        
        ratingLabel.text = "\(floor(rating * 10) / 10)"
        ratingLabel.layoutIfNeeded()
        var ratingInt = Int(ceil(rating / 2))
        if rating / 2 - floor(rating / 2) > 0.0 {
            ratingInt -= 1
        }
        
        let remainRating = rating / 2 - floor(rating / 2) > 0.0 ? 5 - ratingInt - 1 : 5 - ratingInt
        
        if ratingInt > 1 {
            for _ in 1...ratingInt {
                let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
                starImageView.tintColor = .orange
                starImageView.contentMode = .scaleAspectFit
                stackView.addArrangedSubview(starImageView)
            }
        }
        
        if rating / 2 - floor(rating / 2) > 0.0 {
            let starImageView = UIImageView(image: UIImage(systemName: "star.leadinghalf.fill"))
            starImageView.tintColor = .orange
            starImageView.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(starImageView)
        }
        
        if remainRating > 0 {
            for _ in 1...remainRating {
                let starImageView = UIImageView(image: UIImage(systemName: "star"))
                starImageView.tintColor = .orange
                starImageView.contentMode = .scaleAspectFit
                stackView.addArrangedSubview(starImageView)
            }
        }
    }
}
