//
//  DiscoverView.swift
//  MovieApp
//
//  Created by Esra Türk on 26.12.2024.
//

import SwiftUI

struct DiscoverView: View {
    @StateObject private var viewmodel = DiscoverViewModel()
    @Namespace var namespace
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                HeaderView(title: "Discover", size: 35)

                HScrollView(items: viewmodel.genreMovies) { genre in
                    GenreCard(genre: genre, namespace: namespace, selectedGenre: $viewmodel.selectedGenre)
                        .onTapGesture {
                            handleGenreSelection(genre)
                        }
                }
                
                MovieGridView(items: viewmodel.moviesByGenre) { movie in
                    MovieCard(movie: movie, type: .grid)
                        .onTapGesture {
                            viewmodel.selectedMovie = movie
                        }
                }
                
            }
        }
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.background)
        .fullScreenCover(item: $viewmodel.selectedMovie, content: { movie in
            MovieDetailView(movie: movie)
        })
        .task {
            await viewmodel.fetchGenreMovies()
            await viewmodel.fetchMoviesByGenre()
        }
    }
    
    
    private func handleGenreSelection(_ genre: Genre) {
        withAnimation(.smooth) {
            viewmodel.selectedGenre = genre
            Task {
                await viewmodel.fetchMoviesByGenre()
            }
        }
    }
}

#Preview {
    DiscoverView()
}
