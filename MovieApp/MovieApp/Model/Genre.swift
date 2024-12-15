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
