//
//  FavoritesViewModel.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Movie] = []
    private let movieService: MovieService = MovieService()

    func getFavorites() async {
        do {
            let response : MovieResponse = try await movieService.fetchData(api: ApiConstructor(endpoint: .getFavoriteMovies, params: [
                "session_id" : "\(Constants.sessionId)"
                
            ]))
            favorites = response.results
            
            for movie in favorites {
                print(movie.title)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
   func removeFavorite(movieID: Int) async {
        do {
            let request = MediaRequest(mediaID: movieID, mediaType: "movie", favorite: false)
            let api = ApiConstructor(endpoint: .addFavoriteMovies, params: [
                "session_id" : "\(Constants.sessionId)"
            ])
            
            let response: MediaResponse = try await movieService.postData(api: api, requestBody: request)
            print("Success: \(response.success), Message: \(response.statusMessage)")
                   
        } catch {
            print("error : \(error.localizedDescription)")
        }
    }
    
}
