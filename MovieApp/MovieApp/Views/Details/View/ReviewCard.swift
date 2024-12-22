//
//  ReviewCard.swift
//  MovieApp
//
//  Created by Esra Türk on 18.12.2024.
//

import SwiftUI

struct ReviewCard: View {
    let review : Review
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: review.authorImage)) { image in
                    image.resizable()
                } placeholder: {
                    ZStack {
                        Color.gray1
                        if let firstLetter = review.authorName.first {
                            Text(String(firstLetter))
                        }
                    }
                }
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                
                Text(review.authorName)
                    .poppins("Poppins-Regular", 16)
                    
            }
            
            Text(review.content)
                .poppins("Poppins-Light")
            
            Divider()
        }
    }
}

#Preview {
    ReviewCard(review: DeveloperPreview.instance.review)
}
