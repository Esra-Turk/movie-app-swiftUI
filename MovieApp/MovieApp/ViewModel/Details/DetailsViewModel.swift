//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation

@MainActor
class DetailsViewModel : ObservableObject {
    let movie : Movie
    let sections : [DetailViewSection] = [.about,.review, .cast]
    @Published var selectedSection : DetailViewSection = .about
    @Published var reviews : [Review] = []
    
    private let movieService = MovieService()
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchReviews() async {
        do {
            let response : ReviewResponse = try await movieService.fetchData(api: ApiConstructor(endpoint: .movieReview(movie.id)))
            reviews = response.results
        } catch {
            print("Error : \(error.localizedDescription)")
        }
    }
}
