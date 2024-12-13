//
//  ApiConstructor.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import Foundation

typealias Parameters = [String : String]

struct ApiConstructor {
    let endpoint: Endpoint
    var params: Parameters = [:]
}
