//
//  MovieListRouter.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import Foundation
import UIKit

class MovieListRouter: PresenterToRouterMovieListProtocol {
    static func createModule(with genre: String) -> UIViewController {
        let viewController = MovieListViewController(with: genre)
        let presenter: ViewToPresenterMovieListProtocol & InteractorToPresenterMovieListProtocol = MovieListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = MovieListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MovieListInteractor(
            moviesFetcher: FetchMoviesService(
                requestManager: RequestManager()
            )
        )
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}
