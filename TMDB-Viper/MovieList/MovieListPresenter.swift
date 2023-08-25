//
//  MovieListPresenter.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import Foundation

class MovieListPresenter: ViewToPresenterMovieListProtocol {
    var view: PresenterToViewMovieListProtocol?
    
    var interactor: PresenterToInteractorMovieListProtocol?
    
    var router: PresenterToRouterMovieListProtocol?
    
    func updateView(genre: String, page: Int) async {
        await interactor?.fetchMovieList(genre: genre, page: page)
    }
    
    func getMovieList() -> Movies? {
        return interactor?.movies
    }
}


extension MovieListPresenter: InteractorToPresenterMovieListProtocol {
    func movieListFetched() {
        view?.showMovieList()
    }
}
