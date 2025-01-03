//
//  Movie.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle, overview: String
    let popularity: Double
    let posterPath : String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct CategorizedMovies {
    let genreId: Int
    let movies: [Movie]
}

extension Movie {
    var imageUrlString : String {
        Constants.imageBaseURL + (posterPath ?? "")
    }
    
    var imageUrlBackdrop : String {
        Constants.imageBaseURL + (backdropPath ?? "")
    }
    
    var releaseYear : String {
        String(releaseDate.split(separator: "-").first ?? "")
    }
    
    var voteMovie : String {
        let rounded = String(format: "%.1f", voteAverage)
        return rounded
    }

}
