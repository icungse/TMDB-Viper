//
//  DetailMovieRequest.swift
//  TMDB-Viper
//
//  Created by Icung on 26/08/23.
//

import Foundation

enum DetailMovieRequest: RequestProtocol {
    case getDetailMoviesWith(id: Int)
    case getDetailMovieTrailerWith(id: Int)
    case getDetailMovieReviewsWith(id: Int, page: Int)
    
    var path: String {
        switch self {
        case let .getDetailMoviesWith(id: id):
            return "/3/movie/\(id)"
        case let .getDetailMovieTrailerWith(id: id):
            return "/3/movie/\(id)/videos"
        case let .getDetailMovieReviewsWith(id: id, page: _):
            return "/3/movie/\(id)/reviews"
        }
    }
    
    var urlParams: [String : Any] {
        switch self {
        case let .getDetailMovieReviewsWith(id: _, page: page):
            var params: [String: Any] = [:]
            params["page"] = page
            return params
        default:
            return [:]
        }
    }
    
    var requestType: RequestType {
        .GEt
    }
}
