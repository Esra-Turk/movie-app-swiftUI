//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation

@MainActor
class HomeViewModel : ObservableObject {
    @Published var trendingMovies : [Movie] = []
    @Published var topRatedMovies : [Movie] = []
    @Published var genreMovies : [Genre] = []
    @Published var nowPlayingMovies : [Movie] = []
    @Published var moviesByGenre: [Movie] = []
    @Published var errorMessage = ""
    @Published var selectedGenre = DeveloperPreview.instance.genre
    
    private let movieService = MovieService()
    
    private func fetchMovies(endpoint: Endpoint, updateMovies: @escaping ([Movie]) -> Void) async {
        do {
            let movieApiResponse: MovieResponse = try await movieService.fetchData(api: ApiConstructor(endpoint: endpoint))
            updateMovies(movieApiResponse.results)
        } catch {
            errorMessage = "Error: \(error)"
        }
    }
    
    func fetchTrendingMovies() async {
        await fetchMovies(endpoint: .trending) { [weak self] movies in
            self?.trendingMovies = movies
        }
    }
    
    func fetchTopRatedMovies() async {
        await fetchMovies(endpoint: .topRated) { [weak self] movies in
            self?.topRatedMovies = movies
        }
    }
    
    func fetchNowPlayingMovies() async {
        await fetchMovies(endpoint: .nowplaying) { [weak self] movies in
            self?.nowPlayingMovies = movies
        }
    }
    
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
