//
//  DetailMoviePresenter.swift
//  TMDB-Viper
//
//  Created by Icung on 26/08/23.
//

import Foundation

class DetailMoviePresenter: ViewToPresenterDetailMovieProtocol {
    var view: PresenterToViewDetailMovieProtocol?
    var interactor: PresenterToInteractorDetailMovieProtocol?
    var router: PresenterToRouterDetailMovieProtocol?
    
    func updateView(id: Int) async {
        await interactor?.fetchDetailMovie(id: id)
    }
    
    func fetchVideos(id: Int) async {
        await interactor?.fetchDetailMovieVideos(id: id)
    }
    
    func fetchReviews(id: Int, page: Int) async {
        await interactor?.fetchDetailMovieReviews(id: id, page: page)
    }
    
    func getDetailMovie() -> Movie? {
        return interactor?.movie
    }
    
    func getDetailMovieTrailer() -> Videos? {
        return interactor?.videos
    }
    
    func getDetailMovieReviews() -> Reviews? {
        return interactor?.reviews
    }
}

extension DetailMoviePresenter: InteractorToPresenterDetailMovieProtocol {
    func detailMovieVideosFetched() {
        view?.bindMovieTrailer()
    }
    
    func detailMovieFetched() {
        view?.showDetailMovie()
    }
    
    func detailMovieReviewFetched() {
        view?.bindMovieReviews()
    }
}
