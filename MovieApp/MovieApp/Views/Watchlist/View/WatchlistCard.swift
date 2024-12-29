//
//  WatchlistCard.swift
//  MovieApp
//
//  Created by Esra Türk on 28.12.2024.
//

import SwiftUI
import Kingfisher

struct WatchlistCard:  View {
    let movie: Movie
    @ObservedObject var watchlistViewmodel : WatchlistViewModel

    var body: some View {
        HStack(alignment: .top) {
            movieImage
            movieDetails
                .padding(.leading, 8)
        }
        .background(Color.background)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: - Subviews
    private var movieImage: some View {
        KFImage(URL(string: movie.imageUrlString))
            .resizable()
            .frame(width: 150, height: 200)
            .cornerRadius(10)
    }

    private var movieDetails: some View {
        VStack(alignment: .leading, spacing: 10) {
            movieTitle
            movieReleaseYear
            movieInfo
        }
    }

    private var movieTitle: some View {
        Text(movie.title)
            .poppins("Poppins-Bold", 20)
            .foregroundColor(.white)
    }

    private var movieReleaseYear: some View {
        Text(movie.releaseYear)
            .poppins("Poppins-Regular", 20)
            .foregroundColor(.white)
    }

    private var movieInfo: some View {
        VStack(alignment: .leading, spacing: 15) {
            ratingView
            removeButton
        }
    }

    private var ratingView: some View {
        HStack {
            Image("Star2")
            Text("\(movie.voteMovie) IMDb")
                .poppins("Poppins-Regular", 15)
                .foregroundColor(.white)
        }
    }

    private var removeButton: some View {
        Button {
            Task {
                await watchlistViewmodel.updateWatchlist(movie: movie, addToWatchlist: false)
            }
            
        } label: {
            Image("x-mark")
            Text("Remove")
                .poppins("Poppins-Regular", 15)
                .foregroundColor(.white)
        }

    }
}
