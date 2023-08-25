//
//  GenreListRouter.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import Foundation
import UIKit

class GenreListRouter: PresenterToRouterGenreListProtocol {
    static func createModule() -> UIViewController {
        let viewController = GenreListViewController()
        let presenter: ViewToPresenterGenreListProtocol & InteractorToPresenterGenreListProtocol = GenreListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = GenreListRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = GenreListInteractor(
            genreFetcher: FetchGenreService(
                requestManager: RequestManager()
            )
        )
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}


