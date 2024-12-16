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
                Text("Movie App")
                    .font(.largeTitle)
                    .bold()
                
                
                SearchBar(searchText: $searchText)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewmodel.trendingMovies) { movie in
                            MovieCard(movie: movie)
                                .onTapGesture {
                                    viewmodel.selectedMovie = movie
                                }
                        }
                    }
                   
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewmodel.genreMovies) { genre in
                            GenreCard(genre: genre, namespace: namespace, selectedGenre: $viewmodel.selectedGenre)
                                .onTapGesture {
                                    withAnimation(.smooth) {
                                        viewmodel.selectedGenre = genre
                                            Task {
                                            await viewmodel.fetchMoviesByGenre()
                                        }
                                    }
                                    
                                }
                        }
                    }
                   
                }
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewmodel.moviesByGenre){ movie in
                        MovieCard(movie: movie, type: .grid)}
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
            await viewmodel.fetchTrendingMovies()
            await viewmodel.fetchTopRatedMovies()
            await viewmodel.fetchGenreMovies()
            await viewmodel.fetchMoviesByGenre()
        }
    }
}

#Preview {
    HomeView()
}
