//
//  MovieListInteractor.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import Foundation

class MovieListInteractor: PresenterToInteractorMovieListProtocol {
    var presenter: InteractorToPresenterMovieListProtocol?
    
    var movies: Movies?
    
    private let moviesFetcher: MoviesFetcher
    
    init(moviesFetcher: MoviesFetcher) {
        self.moviesFetcher = moviesFetcher
    }
    
    func fetchMovieList(genre: String, page: Int) async {
        movies = await moviesFetcher.fetchMovies(genre: genre, page: page)
        presenter?.movieListFetched()
    }
}
