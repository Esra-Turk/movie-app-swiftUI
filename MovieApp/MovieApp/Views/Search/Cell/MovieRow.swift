//
//  MovieRow.swift
//  MovieApp
//
//  Created by Esra Türk on 24.12.2024.
//

import SwiftUI
import Kingfisher

struct MovieRow: View {
    let movie: Movie

    var body: some View {
        HStack(alignment: .top) {
            movieImage
            movieDetails
                .padding(.leading, 8)
        }
        .background(Color.background)
        .cornerRadius(12)
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
            .poppins("Poppins-Bold", 22)
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
            trailerButton
        }
    }

    private var ratingView: some View {
        HStack {
            Image("Star2")
            Text("\(movie.voteMovie) IMDb")
                .poppins("Poppins-Regular", 15)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
                .font(.system(size: 25))
        }
    }

    private var trailerButton: some View {
        HStack {
            Image("play-small")
            Text("Trailer")
                .poppins("Poppins-Regular", 15)
                .foregroundColor(.white)
        }
    }
}


#Preview {
    MovieRow(movie: DeveloperPreview.instance.movie)
}
