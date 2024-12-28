//
//  WatchlistView.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import SwiftUI

struct WatchlistView: View {
    @StateObject private var watchlistViewmodel = WatchlistViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack (alignment: .leading, spacing: 20) {
                HeaderView(title: "Watchlist", size: 35)
                
                HStack {
                    HeaderView(title: "Movies", size: 25)
                    Spacer()
                    FilterMenu()
                }
                .padding(.horizontal,10)
                
               
               ForEach(watchlistViewmodel.watchlistMovies) { movie in
                   WatchlistCard(movie: movie, watchlistViewmodel: watchlistViewmodel )
                        .onTapGesture {
                            watchlistViewmodel.selectedMovie = movie
                        }
                }
                
                
            }
            .preferredColorScheme(.dark)
            .padding()
            .background(Color.background)
            .task {
                await watchlistViewmodel.getWatchlist()
            }
            .fullScreenCover(item: $watchlistViewmodel.selectedMovie, content: { movie in
                    MovieDetailView(movie: movie)
            })
            
        }
        .background(Color.background.ignoresSafeArea()) 
    }
}

#Preview {
    WatchlistView()
}
