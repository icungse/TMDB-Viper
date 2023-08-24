//
//  GenreListInteractor.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import Foundation

class GenreListInteractor: PresenterToInteractorGenreListProtocol {
    var presenter: InteractorToPresenterGenreListProtocol?
    var genres: Genres?
    
    private let genreFetcher: GenreFetcher
    
    init(genreFetcher: GenreFetcher) {
        self.genreFetcher = genreFetcher
    }
    
    func fetchGenreList() async {
        genres = await genreFetcher.fetchGenre()
        presenter?.genreListFetched()
    }
}
