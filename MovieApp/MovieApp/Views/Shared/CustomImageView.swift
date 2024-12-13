//
//  CustomImageView.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import SwiftUI

struct CustomImageView: View {
    let movie: Movie
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    var body: some View {
        
        AsyncImage(url: URL(string: movie.imageUrlString)) { image in
            image
                .resizable()
                .scaledToFill()
            
            
        } placeholder: {
            ZStack {
                Color.gray
                Text(movie.title)
                    .padding()
            }
        }
        .frame(width: itemWidth, height: itemHeight)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    let preview = DeveloperPreview.instance
    return CustomImageView(movie: preview.movie, itemWidth: 150.0, itemHeight: 150.0)
}
