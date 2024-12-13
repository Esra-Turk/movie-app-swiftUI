//
//  URLBuilder.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import Foundation

enum DefaultUrlBuilder {
    static func build(api: ApiConstructor) throws -> URL {
        guard var urlComponents = URLComponents(string: api.endpoint.fullpath) else {
            throw DefaultUrlBuilderError.invalidpath
        }
        urlComponents.queryItems = buildQueryParams(api.params, ["api_key" : Constants.apiKey])
        
        guard let url = urlComponents.url else {
            throw DefaultUrlBuilderError.invalidUrl
        }
        
        return url
    }
    
    static func buildQueryParams(_ params: Parameters...) -> [URLQueryItem] {
        params.flatMap { $0 }.map { URLQueryItem(name: $0.key, value: $0.value)}
    }
}

enum DefaultUrlBuilderError : Error {
    case invalidpath
    case invalidUrl
}
