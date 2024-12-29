//
//  WatchlistViewModel.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation

@MainActor
class WatchlistViewModel : ObservableObject {
    private let movieService : MovieService = MovieService()
    @Published var watchlistMovies : [Movie] = []
    @Published var selectedMovie: Movie? = nil
    
    func getWatchlist() async {
        do {
            let response : MovieResponse = try await movieService.fetchData(api: ApiConstructor(endpoint: .getMovieFromWatchList, params: [
                "session_id" : "\(Constants.sessionId)"
                
            ]))
            watchlistMovies = response.results
            
            for movie in watchlistMovies {
                print(movie.title)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func updateWatchlist(movie: Movie, addToWatchlist: Bool) async {
        do {
            let request = WatchlistRequest(mediaID: movie.id, mediaType: "movie", watchlist: addToWatchlist)
            let api = ApiConstructor(endpoint: .addMovieToWatchList, params: [
                "session_id" : "\(Constants.sessionId)"
            ])
            
            let response: MediaResponse = try await movieService.postData(api: api, requestBody: request)
            
            if response.success && !addToWatchlist {
                watchlistMovies.removeAll { $0.id == movie.id }
            }

            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func filterByPopularity() {
        watchlistMovies.sort { $0.popularity > $1.popularity }
        
    }
    
    func filterByVote() {
        watchlistMovies.sort { $0.voteAverage > $1.voteAverage }
        
    }
    
    func filterByReleaseDate() {
        watchlistMovies.sort { $0.releaseDate < $1.releaseDate }
    }
}
