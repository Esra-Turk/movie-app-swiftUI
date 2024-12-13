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
                        }
                    }
                   
                }
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewmodel.topRatedMovies){ movie in
                        MovieCard(movie: movie, type: .grid)}
                }
              
            }
        }
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.background)
        .task {
            await viewmodel.fetchTrendingMovies()
            await viewmodel.fetchTopRatedMovies()
        }
    }
}

#Preview {
    HomeView()
}
