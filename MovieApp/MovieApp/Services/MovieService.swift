//
//  MovieService.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import Foundation

enum MovieServiceError: Error {
    case invalidResponse
}

protocol MovieServiceProtocol {
    func fetchData<T: Decodable>(api: ApiConstructor) async throws -> T
}

class MovieService: MovieServiceProtocol {
    func fetchData<T: Decodable>(api: ApiConstructor) async throws -> T {
        let url = try DefaultUrlBuilder.build(api: api)
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw MovieServiceError.invalidResponse
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
