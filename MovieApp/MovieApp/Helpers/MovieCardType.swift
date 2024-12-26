//
//  MovieCardType.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import Foundation

enum MovieCardType {
    case poster
    case grid
}

extension MovieCardType {
    var width : Double {
        switch self {
        case .poster: return 0.4
        case .grid: return 0.3
        }
    }
    
    var height : Double {
        switch self {
        case .poster: return 0.3
        case .grid: return 0.2
        }
    }
}
