//
//  MovieCard.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    var type: MovieCardType = .poster
    var body: some View {
        CustomImageView(movie: movie, itemWidth: itemWidth, itemHeight: itemHeight)
    }
}

extension MovieCard {
   var itemWidth: CGFloat {
       screenWidth * type.width
    }
    
    var itemHeight: CGFloat {
        screenHeight * type.height
    }
}

#Preview {
    let preview = DeveloperPreview.instance
    return MovieCard(movie: preview.movie)
}
