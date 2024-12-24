//
//  SearchResultView.swift
//  MovieApp
//
//  Created by Esra Türk on 24.12.2024.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.searchedMovies.isEmpty {
                emptyView
            } else {
                movieListView
            }
        }
        .navigationTitle("Search Results")
        .navigationBarTitleDisplayMode(.inline)
        .tint(.white)
    }
    
    // MARK: - Subviews
    private var emptyView: some View {
        Text("No movies found")
            .foregroundColor(.gray)
            .padding()
    }

    private var movieListView: some View {
        List(viewModel.searchedMovies, id: \.id) { movie in
            MovieRow(movie: movie)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                .padding(.vertical, 8)
                .onTapGesture {
                    viewModel.selectedMovie = movie
                }
        }
        .background(Color.background)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    SearchResultView()
}
