//
//  Genre.swift
//  MovieApp
//
//  Created by Esra Türk on 15.12.2024.
//

import Foundation

struct Genre : Codable, Identifiable {
    let id : Int
    let name : String
}

struct GenreResponse : Codable {
    let genres : [Genre]
}

struct GenreNames {
    static let genreNames: [Int: String] = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
    
    static func name(for id: Int) -> String {
        genreNames[id] ?? "Other"
    }
}
