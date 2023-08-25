//
//  FetchMoviesService.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import Foundation

protocol MoviesFetcher {
    func fetchMovies(genre: String, page: Int) async -> Movies?
}

struct FetchMoviesService {
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension FetchMoviesService: MoviesFetcher {
    func fetchMovies(genre: String, page: Int) async -> Movies? {
        let request = MoviesRequest.getMoviesWith(genre: genre, page: page)
        do {
            let data: Movies = try await requestManager.perform(request)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
