//
//  MovieListContract.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import UIKit

protocol PresenterToRouterMovieListProtocol {
    static func createModule(with genre: String) -> UIViewController
}

protocol PresenterToViewMovieListProtocol {
   func showMovieList()
}

protocol ViewToPresenterMovieListProtocol {
    var view: PresenterToViewMovieListProtocol? { get set }
    var interactor: PresenterToInteractorMovieListProtocol? { get set }
    var router: PresenterToRouterMovieListProtocol? { get set }

    func updateView(genre: String, page: Int) async
    func getMovieList() -> Movies?

}

protocol PresenterToInteractorMovieListProtocol {
    var presenter: InteractorToPresenterMovieListProtocol? { get set }
    var movies: Movies? { get }
    
    func fetchMovieList(genre: String, page: Int) async
}

protocol InteractorToPresenterMovieListProtocol {
    func movieListFetched()
}
