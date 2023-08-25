//
//  Movies.swift
//  TMDB-Viper
//
//  Created by Icung on 25/08/23.
//

import Foundation

struct Movies: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
