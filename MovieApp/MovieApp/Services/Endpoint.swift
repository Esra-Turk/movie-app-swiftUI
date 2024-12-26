//
//  Endpoint.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import Foundation

enum Endpoint {
    case trending, topRated, genre, nowplaying, movieReview(_ id: Int), discoverMovies,
         watchTrailer(_ id: Int), movieCredits(_ id: Int), similarMovies(_ id: Int), searchMovie, addFavoriteMovies, getFavoriteMovies
    
    private var path : String {
        switch self {
        case .trending: return "/trending/movie/week"
        case .topRated: return "/movie/top_rated"
        case .genre: return "/genre/movie/list"
        case .nowplaying: return "/movie/now_playing"
        case .movieReview(let id): return "/movie/\(id)/reviews"
        case .discoverMovies: return "/discover/movie"
        case .watchTrailer(let id): return "/movie/\(id)/videos"
        case .movieCredits(let id): return "/movie/\(id)/credits"
        case .similarMovies(let id): return "/movie/\(id)/similar"
        case .searchMovie: return "/search/movie"
        case .addFavoriteMovies: return "/account/\(Constants.accountId)/favorite"
        case .getFavoriteMovies: return "/account/\(Constants.accountId)/favorite/movies"
        }
    }
    
    var fullpath : String {
        Constants.apiBaseURL + path
    }
}
