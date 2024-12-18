//
//  HomeView.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @StateObject private var viewmodel = HomeViewModel()
    @Namespace var namespace
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                HeaderView(title: "Movie App", size: 35)
                SearchBar(searchText: $searchText)
                
                HeaderView(title: "Trending", size: 18)
                HScrollView(items: viewmodel.trendingMovies) { movie in
                    MovieCard(movie: movie)
                        .onTapGesture {
                            viewmodel.selectedMovie = movie
                        }
                }
                
                HeaderView(title: "Top Rated", size: 18)
                HScrollView(items: viewmodel.topRatedMovies) { movie in
                    MovieCard(movie: movie)
                        .onTapGesture {
                            viewmodel.selectedMovie = movie
                        }
                }
                
                HeaderView(title: "Now Playing", size: 18)
                HScrollView(items: viewmodel.nowPlayingMovies) { movie in
                    MovieCard(movie: movie)
                        .onTapGesture {
                            viewmodel.selectedMovie = movie
                        }
                }
                
                HScrollView(items: viewmodel.genreMovies) { genre in
                    GenreCard(genre: genre, namespace: namespace, selectedGenre: $viewmodel.selectedGenre)
                        .onTapGesture {
                            handleGenreSelection(genre)
                        }
                }
                
                MovieGridView(movies: viewmodel.moviesByGenre)
              
            }
        }
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.background)
        .fullScreenCover(item: $viewmodel.selectedMovie, content: { movie in
            MovieDetailView(movie: movie)
        })
        .task {
            await loadData()
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
    
    private func loadData() async {
        await viewmodel.fetchTrendingMovies()
        await viewmodel.fetchTopRatedMovies()
        await viewmodel.fetchNowPlayingMovies()
        await viewmodel.fetchGenreMovies()
        await viewmodel.fetchMoviesByGenre()
    }
}

#Preview {
    HomeView()
}
