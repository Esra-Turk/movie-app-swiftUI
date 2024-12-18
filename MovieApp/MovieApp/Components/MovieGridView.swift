//
//  MovieGridView.swift
//  MovieApp
//
//  Created by Esra Türk on 18.12.2024.
//

import SwiftUI

struct MovieGridView: View {
    var movies: [Movie]

    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(movies) { movie in
                MovieCard(movie: movie, type: .grid)
            }
        }
    }
}
