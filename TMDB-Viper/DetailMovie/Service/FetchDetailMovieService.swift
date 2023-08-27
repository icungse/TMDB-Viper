//
//  FetchDetailMovieService.swift
//  TMDB-Viper
//
//  Created by Icung on 26/08/23.
//

import Foundation

protocol DetailMovieFetcher {
    func fetchDetailMovie(id: Int) async -> Movie?
    func fetchVideos(id: Int) async -> Videos?
    func fetchReviews(id: Int, page: Int) async -> Reviews?
}

struct FetchDetailMovieService {
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
}

extension FetchDetailMovieService: DetailMovieFetcher {
    func fetchDetailMovie(id: Int) async -> Movie? {
        let request = DetailMovieRequest.getDetailMoviesWith(id: id)
        do {
            let data: Movie = try await requestManager.perform(request)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func fetchVideos(id: Int) async -> Videos? {
        let request = DetailMovieRequest.getDetailMovieTrailerWith(id: id)
        do {
            let data: Videos = try await requestManager.perform(request)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func fetchReviews(id: Int, page: Int) async -> Reviews? {
        let request = DetailMovieRequest.getDetailMovieReviewsWith(id: id, page: page)
        do {
            let data: Reviews = try await requestManager.perform(request)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
