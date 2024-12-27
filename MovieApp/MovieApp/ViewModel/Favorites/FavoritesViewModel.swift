//
//  FavoritesViewModel.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation

@MainActor
class FavoritesViewModel: ObservableObject {
    @Published var selectedMovie: Movie? = nil
    private let movieService: MovieService = MovieService()
    @Published var categorizedFavorites: [CategorizedMovies] = []
    @Published var favorites: [Movie] = [] {
        didSet {
            genreFavorite()
        }
    }

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
            
            if response.success {
                if let index = favorites.firstIndex(where: { $0.id == movieID }) {
                    favorites.remove(at: index)
                }
            }
                   
        } catch {
            print("error : \(error.localizedDescription)")
        }
    }
    
    
    private func genreFavorite() {
        let grouped = Dictionary(grouping: favorites) {
            $0.genreIDS.first ?? 0
        }

        self.categorizedFavorites = grouped.map {
            CategorizedMovies(genreId: $0.key, movies: $0.value)
        }.sorted { $0.genreId < $1.genreId }
    }


}
