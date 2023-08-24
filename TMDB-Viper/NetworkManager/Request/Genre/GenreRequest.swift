//
//  GenreRequest.swift
//  TMDB-Viper
//
//  Created by Icung on 24/08/23.
//

import Foundation

enum GenreRequest: RequestProtocol {
    case getGenre
    
    var path: String {
        return "/3/genre/movie/list"
    }
    
    var requestType: RequestType {
        .GEt
    }
}
