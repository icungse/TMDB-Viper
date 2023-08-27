//
//  Viedeos.swift
//  TMDB-Viper
//
//  Created by Icung on 26/08/23.
//

import Foundation

struct Videos: Codable {
    let id: Int
    let videos: [Video]
    
    enum CodingKeys: String, CodingKey {
        case id
        case videos = "results"
    }
}

struct Video: Codable {
    let iso639_1: String
    let iso3166_1: String
    let name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
