//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation
import Combine

@MainActor
class HomeViewModel : ObservableObject {
    @Published var trendingMovies : [Movie] = []
    @Published var topRatedMovies : [Movie] = []
    @Published var nowPlayingMovies : [Movie] = []
    @Published var errorMessage = ""
    @Published var selectedMovie: Movie? = nil
    @Published var searchedMovies: [Movie] = []
    
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
    
    func searchMovie(query : String) async {
        do {
            let api = ApiConstructor(endpoint: .searchMovie, params: [
                "query" : "\(query)"
            ])
            
            let response : MovieResponse = try await movieService.fetchData(api: api)
            searchedMovies = response.results
            
        } catch {
            errorMessage = "Error: \(error)"
        }
    }
    
}
