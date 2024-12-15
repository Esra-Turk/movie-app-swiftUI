//
//  PreviewProvider.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import SwiftUI

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let movie = Movie(adult: false, backdropPath: "", genreIDS: [1], id: 912649, originalLanguage: "", originalTitle: "", overview: "", popularity: 10.0, posterPath: "/3V4kLQg0kSqPLctI5ziYWabAZYF.jpg", releaseDate: "", title: "Venom: The Last Dance", video: false, voteAverage: 10.0, voteCount: 1)
    
    let genre = Genre(id: 28, name: "Action")
}
