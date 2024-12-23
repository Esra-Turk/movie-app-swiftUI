//
//  Cast.swift
//  MovieApp
//
//  Created by Esra Türk on 23.12.2024.
//

import Foundation

struct CastResponse: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable, Identifiable {
    let id: Int
    let name: String
    let character: String?
    let profilePath: String?
    let popularity: Double

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
        case popularity
    }
}

extension Cast {
    var actorImage: String {
       guard let profilePath else { return "" }
       return Constants.imageBaseURL + profilePath
    }
}
