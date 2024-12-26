//
//  Favorite.swift
//  MovieApp
//
//  Created by Esra Türk on 26.12.2024.
//

import Foundation

struct MediaRequest: Codable {
    let mediaID: Int
    let mediaType: String
    let favorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaID = "media_id"
        case mediaType = "media_type"
        case favorite
    }
}

struct MediaResponse: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
