//
//  Video.swift
//  MovieApp
//
//  Created by Esra Türk on 22.12.2024.
//

import Foundation

// MARK: - VideoResponse
struct VideoResponse: Codable {
    let id: Int
    let results: [Video]
}

// MARK: - Video
struct Video: Codable {
    let iso639_1: ISO639_1
    let iso3166_1: ISO3166_1
    let name, key: String
    let site: Site
    let size: Int
    let type: TypeEnum
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

enum ISO3166_1: String, Codable {
    case us = "US"
}

enum ISO639_1: String, Codable {
    case en = "en"
}

enum Site: String, Codable {
    case youTube = "YouTube"
}

enum TypeEnum: String, Codable {
    case featurette = "Featurette"
    case teaser = "Teaser"
    case trailer = "Trailer"
    case clip = "Clip"
}

extension Video {
    var youtubeURL: URL? {
        guard site == .youTube else { return nil }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
    
}
