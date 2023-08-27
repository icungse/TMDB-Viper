//
//  DetailMovieInteractor.swift
//  TMDB-Viper
//
//  Created by Icung on 26/08/23.
//

import Foundation

class DetailMovieInteractor: PresenterToInteractorDetailMovieProtocol {
    var presenter: InteractorToPresenterDetailMovieProtocol?
    var movie: Movie?
    var videos: Videos?
    var reviews: Reviews?
    
    private let detailMovieFetcher: DetailMovieFetcher
    
    init(detailMovieFetcher: DetailMovieFetcher) {
        self.detailMovieFetcher = detailMovieFetcher
    }
    
    func fetchDetailMovie(id: Int) async {
        movie = await detailMovieFetcher.fetchDetailMovie(id: id)
        presenter?.detailMovieFetched()
    }
    
    func fetchDetailMovieVideos(id: Int) async {
        videos = await detailMovieFetcher.fetchVideos(id: id)
        presenter?.detailMovieVideosFetched()
    }
    
    func fetchDetailMovieReviews(id: Int, page: Int) async {
        reviews = await detailMovieFetcher.fetchReviews(id: id, page: page)
        presenter?.detailMovieReviewFetched()
    }
}
