//
//  FavoritesView.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewmodel: FavoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack (alignment: .leading, spacing: 10){
                HeaderView(title: "Favorites", size: 35)
                
                ForEach(viewmodel.categorizedFavorites, id: \.genreId) { category in
                    VStack(alignment: .leading) {
                        HeaderView(title: GenreNames.name(for: category.genreId), size: 20)
                        HScrollView(items: category.movies) { movie in
                            MovieCard(movie: movie, type: .grid)
                                .onTapGesture {
                                    viewmodel.selectedMovie = movie
                                }
                                .contextMenu {
                                    Button(action: {
                                        Task {
                                            await viewmodel.removeFavorite(movieID: movie.id)
                                        }
                                    }) {
                                        Label("Remove Favorite", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
            .padding()
            .background(Color.background)
    
            .fullScreenCover(item: $viewmodel.selectedMovie, content: { favorite in
                MovieDetailView(movie: favorite)
            })
            .task {
                await viewmodel.getFavorites()
            }
        }
        .background(Color.background.ignoresSafeArea()) 
    }
}

#Preview {
    FavoritesView()
}
