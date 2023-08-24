//
//  GenreListPresenter.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import Foundation

class GenreListPresenter: ViewToPresenterGenreListProtocol {
    var view: PresenterToViewGenreListProtocol?
    var interactor: PresenterToInteractorGenreListProtocol?
    var router: PresenterToRouterGenreListProtocol?
    
    func updateView() async {
        await interactor?.fetchGenreList()
    }
    
    func getGenreList() -> Genres? {
        return interactor?.genres
    }
}

extension GenreListPresenter: InteractorToPresenterGenreListProtocol {
    func genreListFetched() {
        view?.showGenreList()
    }
}
