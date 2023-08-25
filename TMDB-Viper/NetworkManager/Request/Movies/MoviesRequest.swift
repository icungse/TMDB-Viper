//
//  MoviesRequest.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import Foundation

enum MoviesRequest: RequestProtocol {
    case getMoviesWith(genre: String, page: Int)
    
    var path: String {
        return "/3/discover/movie"
    }
    
    var requestType: RequestType {
        .GEt
    }
    
    var urlParams: [String : String?]  {
        switch self {
        case let .getMoviesWith(genre, page):
            var params: [String: String] = [:]
            params["with_genres"] = genre
            params["page"] = String(page)
            
            return params
        }
    }
}
