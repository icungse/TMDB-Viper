//
//  DetailMovieViewController.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import UIKit
import WebKit

class DetailMovieViewController: BaseViewController {
    var presenter: ViewToPresenterDetailMovieProtocol?
    
    private lazy var scrollView = UIScrollView()
    private lazy var contentView = UIView()
    private lazy var detailStackView = UIStackView()
    private lazy var reviewStackView = UIStackView()
    private lazy var trailerView = UIView()
    private lazy var reviewView = UIView()
    private lazy var ratingView = RatingComponent()
    private lazy var headerImageView = ImageLoader()
    private lazy var posterImageView = ImageLoader()
    private lazy var titleLabel = UILabel()
    private lazy var releaseLabel = UILabel()
    private lazy var genreLabel = UILabel()
    private lazy var descriotionLabel = UILabel()
    private lazy var trailerTitleLabel = UILabel()
    private lazy var reviewTitleLabel = UILabel()
    private lazy var webView = WKWebView()
    private var collectionViewlayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }
    private lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionViewlayout)
    
    let id: Int
    private var reviews: [Review] = []
    private var reviewPage = 1
    private var reviewTotalPage = 1
    
    init(with id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        isLoading = true
        
        Task {
            await presenter?.updateView(id: id)
            await presenter?.fetchVideos(id: id)
            await fetchReview()
        }
    }
}

extension DetailMovieViewController {
    private func fetchReview() async {
        await presenter?.fetchReviews(id: id, page: reviewPage)
    }
    
    private func setupView() {
        setupHeaderView()
        setupScrollView()
        setupContentView()
        setupCardDetail()
        setupTrailerView()
        setupTrailerTitleLabel()
        setupWebView()
        setupReviewStackView()
        setupReviewTitleLabel()
        setupCollectionView()
    }
    
    private func setupHeaderView() {
        view.addSubview(headerImageView)
        headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.contentMode = .scaleAspectFill
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.bringSubviewToFront(headerImageView)
    }
    
    private func setupCardDetail() {
        contentView.addSubview(detailStackView)
        detailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        detailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        detailStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        detailStackView.axis = .horizontal
        detailStackView.alignment = .leading
        detailStackView.spacing = 8
        
        setupRightStackView()
        setupLeftStackView()
    }
    
    private func setupRightStackView() {
        let leftStackView = UIStackView()
        leftStackView.axis = .vertical
        detailStackView.addArrangedSubview(leftStackView)
        
        posterImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.6).isActive = true
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.addArrangedSubview(posterImageView)
        
        ratingView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.addArrangedSubview(ratingView)
    }
    
    private func setupLeftStackView() {
        let rightStackView = UIStackView()
        rightStackView.axis = .vertical
        detailStackView.addArrangedSubview(rightStackView)
        
        rightStackView.addArrangedSubview(titleLabel)
        titleLabel.applyStyle(size: 20, color: .label, isBold: true)
        
        rightStackView.addArrangedSubview(releaseLabel)
        releaseLabel.applyStyle(size: 12, color: .quaternaryLabel)
        
        rightStackView.addArrangedSubview(genreLabel)
        genreLabel.applyStyle(size: 12, color: .tertiaryLabel)
        
        rightStackView.addArrangedSubview(descriotionLabel)
        descriotionLabel.applyStyle(linesCount: 0, size: 16, color: .label)
    }
    
    private func setupTrailerView() {
        contentView.addSubview(trailerView)
        trailerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        trailerView.topAnchor.constraint(equalTo: detailStackView.bottomAnchor, constant: 16).isActive = true
        trailerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        trailerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupTrailerTitleLabel() {
        trailerView.addSubview(trailerTitleLabel)
        trailerTitleLabel.text = "Trailer"
        trailerTitleLabel.applyStyle(size: 18, color: .label, isBold: true)
        trailerTitleLabel.leadingAnchor.constraint(equalTo: trailerView.leadingAnchor).isActive = true
        trailerTitleLabel.topAnchor.constraint(equalTo: trailerView.topAnchor).isActive = true
        trailerTitleLabel.trailingAnchor.constraint(equalTo: trailerView.trailingAnchor).isActive = true
        trailerTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupWebView() {
        trailerView.addSubview(webView)
        webView.leadingAnchor.constraint(equalTo: trailerView.leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: trailerTitleLabel.bottomAnchor, constant: 8).isActive = true
        webView.trailingAnchor.constraint(equalTo: trailerView.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: -16).isActive = true
        webView.widthAnchor.constraint(equalToConstant: trailerView.frame.width).isActive = true
        webView.heightAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 0.56).isActive = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func setupReviewStackView() {
        contentView.addSubview(reviewStackView)
        reviewStackView.addArrangedSubview(reviewView)
        reviewStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        reviewStackView.topAnchor.constraint(equalTo: trailerView.bottomAnchor, constant: 16).isActive = true
        reviewStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        reviewStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
        reviewStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupReviewTitleLabel() {
        reviewView.addSubview(reviewTitleLabel)
        reviewTitleLabel.leadingAnchor.constraint(equalTo: reviewView.leadingAnchor, constant: 16).isActive = true
        reviewTitleLabel.topAnchor.constraint(equalTo: reviewView.topAnchor).isActive = true
        reviewTitleLabel.trailingAnchor.constraint(equalTo: reviewView.trailingAnchor, constant: -16).isActive = true
        reviewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewTitleLabel.text = "Review"
        reviewTitleLabel.applyStyle(size: 18, color: .label, isBold: true)
    }
    
    private func setupCollectionView() {
        reviewView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: reviewView.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: reviewTitleLabel.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: reviewView.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: reviewView.bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 377.0).isActive = true
    }
    
    private func adjustOpacity(_ value: Float) {
        headerImageView.layer.opacity = value
    }
}

extension DetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath)
        (cell as? ReviewCollectionViewCell)?.review = reviews[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 54) / 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == reviews.count - 1 {
            guard reviewPage <= reviewTotalPage else {
                return
            }
            
            Task {
                await fetchReview()
            }
        }
    }
}

extension DetailMovieViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y > 0 else {
            return
        }
        adjustOpacity(Float(scrollView.contentOffset.y / 200 - 1.0) * -1)
    }
}

extension DetailMovieViewController: PresenterToViewDetailMovieProtocol {
    func showDetailMovie() {
        isLoading = false
        let movie = presenter?.getDetailMovie()
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let movie = movie else {
                return
            }
            self.bindView(movie: movie)
        }
    }
    
    private func bindView(movie: Movie) {
        headerImageView.loadImageWithUrl(movie.backdropPath, scale: .scaleAspectFill)
        if let path = movie.posterPath {
            posterImageView.loadImageWithUrl(path)
        }
        titleLabel.text = movie.title
        releaseLabel.text = movie.releaseDate
        var genreString = ""
        let genres = movie.genres
        for i in 0..<genres.count {
            genreString += genres[i].name
            if i != genres.count - 1 {
                genreString += "•"
            }
        }
        genreLabel.text = genreString
        descriotionLabel.text = movie.overview
        ratingView.rating = movie.voteAverage
    }
    
    func bindMovieTrailer() {
        let videos = presenter?.getDetailMovieTrailer()
        let trailer = videos?.videos.filter {
            $0.type == "Trailer"
        }.first
        
        DispatchQueue.main.async { [weak self] in
            guard
                let self = self,
                let trailer = trailer,
                let url = URL(string: "https://www.youtube.com/embed/\(trailer.key)")
            else {
                return
            }
            
            self.webView.load(URLRequest(url: url))
        }
    }
    
    func bindMovieReviews() {
        guard let review = presenter?.getDetailMovieReviews() else {
            return
        }
        
        self.reviews += review.reviews
        reviewTotalPage = review.totalPages
        reviewPage += 1
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.reviewView.isHidden = review.totalResults == 0
            self.collectionView.reloadData()
            self.reviewView.layoutSubviews()
        }
    }
}
