//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation

protocol MovieService {
    func fetchMovies(endpoint: MovieListEndpoint) async throws -> MovieResponse
    func fetchMovie(id: Int) async throws -> Movie
    func searchMovie(query: String) async throws -> MovieResponse
}

enum MovieListEndpoint: String {
    case playing = "now_playing"
    case upcoming
    case popular
    case topRated = "top_rated"
    
    var description: String {
        switch self {
        case .playing: return "Now Playing"
        case .upcoming: return "Upcoming"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        }
        
        
    }
    
}

enum MovieError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    var localizedDescription: String {
        switch self {
        case .apiError: return "An error occurred while communicating with the API"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Serialization error"
        }
    }
    
    var errorUserInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
