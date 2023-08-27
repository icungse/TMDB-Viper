//
//  DetailMovieRouter.swift
//  TMDB-Viper
//
//  Created by Icung on 26/08/23.
//

import Foundation
import UIKit

class DetailMovieRouter: PresenterToRouterDetailMovieProtocol {
    
    static func createModule(with id: Int) -> UIViewController {
        let viewController = DetailMovieViewController(with: id)
        let presenter: ViewToPresenterDetailMovieProtocol & InteractorToPresenterDetailMovieProtocol
        = DetailMoviePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DetailMovieRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DetailMovieInteractor(
            detailMovieFetcher:FetchDetailMovieService(
                requestManager: RequestManager()
            )
        )
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}

