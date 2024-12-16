//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation

class DetailsViewModel : ObservableObject {
    let movie : Movie
    let sections : [DetailViewSection] = [.about,.review, .cast]
    @Published var selectedSection : DetailViewSection = .about
    
    init(movie: Movie) {
        self.movie = movie
    }
}
