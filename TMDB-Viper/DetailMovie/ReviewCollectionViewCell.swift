//
//  ReviewCollectionViewCell.swift
//  TMDB-Viper
//
//  Created by Icung on 26/08/23.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    lazy var containerView = UIView()
    lazy var ratingView = RatingComponent()
    lazy var reviewerNameLabel = UILabel()
    lazy var createdDateLabel = UILabel()
    lazy var reviewDescriptionTextView = UITextView()
    
    var review: Review? {
        didSet {
            bindData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
        setupRatingView()
        setupReviewerLabel()
        setupCreatedDateLabel()
        setupReviewDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ratingView.rating = 0
    }
}

extension ReviewCollectionViewCell {
    private func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    private func setupRatingView() {
        containerView.addSubview(ratingView)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        ratingView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        ratingView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ratingView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    private func setupReviewerLabel() {
        containerView.addSubview(reviewerNameLabel)
        reviewerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewerNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        reviewerNameLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 0).isActive = true
        reviewerNameLabel.applyStyle(color: .label, isBold: true)
    }
    
    private func setupCreatedDateLabel() {
        containerView.addSubview(createdDateLabel)
        createdDateLabel.translatesAutoresizingMaskIntoConstraints = false
        createdDateLabel.leadingAnchor.constraint(equalTo: reviewerNameLabel.trailingAnchor, constant: 4).isActive = true
        createdDateLabel.topAnchor.constraint(equalTo: reviewerNameLabel.topAnchor).isActive = true
        createdDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16).isActive = true
        createdDateLabel.applyStyle(color: .secondaryLabel, isBold: false)
    }
    
    private func setupReviewDescriptionLabel() {
        containerView.addSubview(reviewDescriptionTextView)
        reviewDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        reviewDescriptionTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8).isActive = true
        reviewDescriptionTextView.topAnchor.constraint(equalTo: createdDateLabel.bottomAnchor, constant: 8).isActive = true
        reviewDescriptionTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8).isActive = true
        reviewDescriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8).isActive = true
        reviewDescriptionTextView.isScrollEnabled = false
        reviewDescriptionTextView.font = .systemFont(ofSize: 12)
        reviewDescriptionTextView.textContainer.lineBreakMode = .byTruncatingTail
        reviewDescriptionTextView.allowsEditingTextAttributes = false
    }
    
    private func bindData() {
        ratingView.rating = Double(review?.authorDetails.rating ?? 0 / 5)
        reviewerNameLabel.text = review?.author
        createdDateLabel.text = review?.createdAt.formatDate()
        reviewDescriptionTextView.text = review?.content
        contentView.layoutIfNeeded()
    }
}
