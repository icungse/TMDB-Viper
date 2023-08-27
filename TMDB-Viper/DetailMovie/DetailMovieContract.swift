//
//  DetailMovieContract.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import UIKit

protocol PresenterToViewDetailMovieProtocol {
    func showDetailMovie()
    func bindMovieTrailer()
    func bindMovieReviews()
}

protocol ViewToPresenterDetailMovieProtocol {
    
    var view: PresenterToViewDetailMovieProtocol? { get set }
    var interactor: PresenterToInteractorDetailMovieProtocol? { get set }
    var router: PresenterToRouterDetailMovieProtocol? { get set }

    func updateView(id: Int) async
    func fetchVideos(id: Int) async
    func fetchReviews(id: Int, page: Int) async
    func getDetailMovie() -> Movie?
    func getDetailMovieTrailer() -> Videos?
    func getDetailMovieReviews() -> Reviews?
}

protocol PresenterToInteractorDetailMovieProtocol {
    
    var presenter: InteractorToPresenterDetailMovieProtocol? { get set }
    var movie: Movie? { get }
    var videos: Videos? { get }
    var reviews: Reviews? { get }
    
    func fetchDetailMovie(id: Int) async
    func fetchDetailMovieVideos(id: Int) async
    func fetchDetailMovieReviews(id: Int, page: Int) async
}

protocol InteractorToPresenterDetailMovieProtocol {
    func detailMovieFetched()
    func detailMovieVideosFetched()
    func detailMovieReviewFetched()
}

protocol PresenterToRouterDetailMovieProtocol {
    static func createModule(with id: Int) -> UIViewController
}
