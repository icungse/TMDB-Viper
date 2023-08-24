//
//  FetchGenreService.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import Foundation

protocol GenreFetcher {
    func fetchGenre() async -> Genres?
}

struct FetchGenreService {
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension FetchGenreService: GenreFetcher {
    func fetchGenre() async -> Genres? {
        let request = GenreRequest.getGenre
        do {
            let data: Genres = try await requestManager.perform(request)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
