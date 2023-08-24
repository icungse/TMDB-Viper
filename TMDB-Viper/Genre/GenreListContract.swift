//
//  GenreListContract.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import UIKit

protocol PresenterToRouterGenreListProtocol {
    static func createModule() -> UIViewController
}

protocol PresenterToViewGenreListProtocol {
   func showGenreList()
}

protocol ViewToPresenterGenreListProtocol {
    var view: PresenterToViewGenreListProtocol? { get set }
    var interactor: PresenterToInteractorGenreListProtocol? { get set }
    var router: PresenterToRouterGenreListProtocol? { get set }

    func updateView() async
    func getGenreList() -> Genres?

}

protocol PresenterToInteractorGenreListProtocol {
    var presenter: InteractorToPresenterGenreListProtocol? { get set }
    var genres: Genres? { get }
    
    func fetchGenreList() async
}

protocol InteractorToPresenterGenreListProtocol {
    func genreListFetched()
}
