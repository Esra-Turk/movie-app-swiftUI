//
//  Endpoint.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import Foundation

enum Endpoint {
    case trending, topRated, genre, nowplaying, movieReview(_ id: Int), movieDetails(_ id: Int)
    
    private var path : String {
        switch self {
        case .trending: return "/trending/movie/week"
        case .topRated: return "/movie/top_rated"
        case .genre: return "/genre/movie/list"
        case .nowplaying: return "/movie/now_playing"
        case .movieDetails(let id): return "/movie/\(id)"
        case .movieReview(let id): return "/movie/\(id)/reviews"
        }
    }
    
    var fullpath : String {
        Constants.apiBaseURL + path
    }
}
