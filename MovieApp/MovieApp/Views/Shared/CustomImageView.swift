//
//  CustomImageView.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import SwiftUI
import Kingfisher

struct CustomImageView: View {
    let movie: Movie
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    var imageType: String = "poster"
    
    var body: some View {
        
        let imageUrl: String? = {
            switch imageType {
            case "backdrop":
                return movie.backdropPath != nil ? movie.imageUrlBackdrop : nil
            default:
                return movie.posterPath != nil ? movie.imageUrlString : nil
            }
        }()
        
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            KFImage(url)
                .placeholder {
                    ZStack {
                        Color.gray
                        Text(movie.title)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                .resizable()
                .scaledToFill()
                .frame(width: itemWidth, height: itemHeight)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    let preview = DeveloperPreview.instance
    return CustomImageView(movie: preview.movie, itemWidth: 150.0, itemHeight: 150.0)
}
