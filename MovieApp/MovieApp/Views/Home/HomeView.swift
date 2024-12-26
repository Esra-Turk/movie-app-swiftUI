//
//  HomeView.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var showSearchResults = false
    @StateObject private var viewmodel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 20) {
                    HeaderView(title: "Movie App", size: 35)
                    
                    SearchBar(searchText: $searchText)
                        .onSubmit {
                            Task {
                                await viewmodel.searchMovie(query: searchText)
                                showSearchResults = true
                            }
                        }
                    
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
                    
                    
                }
            }
            .preferredColorScheme(.dark)
            .padding()
            .background(Color.background)
            .fullScreenCover(item: $viewmodel.selectedMovie, content: { movie in
                MovieDetailView(movie: movie)
            })
            .navigationDestination(isPresented: $showSearchResults) {
                SearchResultView(viewModel: viewmodel)
                    .onDisappear() {
                        searchText = ""
                    }
            }
            .task {
                await loadData()
            }
        }
    }
    
    
    private func loadData() async {
        await viewmodel.fetchTrendingMovies()
        await viewmodel.fetchTopRatedMovies()
        await viewmodel.fetchNowPlayingMovies()
    }
}

#Preview {
    HomeView()
}
