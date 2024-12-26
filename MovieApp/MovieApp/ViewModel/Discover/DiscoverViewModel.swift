//
//  DiscoverViewModel.swift
//  MovieApp
//
//  Created by Esra Türk on 26.12.2024.
//

import Foundation

@MainActor
class DiscoverViewModel: ObservableObject {
    @Published var moviesByGenre: [Movie] = []
    @Published var genreMovies : [Genre] = []
    @Published var errorMessage = ""
    @Published var selectedGenre = DeveloperPreview.instance.genre
    @Published var selectedMovie: Movie? = nil
    
    private let movieService = MovieService()
    
    func fetchGenreMovies() async {
        do {
            let response: GenreResponse = try await movieService.fetchData(api: .init(endpoint: .genre))
            genreMovies = response.genres
            
            if let genre = genreMovies.first {
                selectedGenre = genre
            }
        } catch {
            errorMessage = "Error: \(error)"
        }
    }
    
    func fetchMoviesByGenre() async {
        do {
            let api = ApiConstructor(endpoint: .discoverMovies, params: [
                "with_genres" : "\(selectedGenre.id)"
            ])
        
            let response: MovieResponse = try await movieService.fetchData(api: api)
            moviesByGenre = response.results
        } catch {
            print("Error fetching movies by genre: \(error)")
        }

    }
}
