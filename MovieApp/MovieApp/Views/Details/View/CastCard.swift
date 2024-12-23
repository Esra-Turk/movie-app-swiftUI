//
//  CastC.swift
//  MovieApp
//
//  Created by Esra Türk on 23.12.2024.
//

import SwiftUI

struct CastCard: View {
    let cast : Cast
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: cast.actorImage)) { image in
                image.resizable()
            } placeholder: {
                Color.background
            }
            .frame(width: 130, height: 140)
            .aspectRatio(contentMode: .fill)
            .clipped()

            
            VStack(alignment: .leading, spacing: 10) {
                Text(cast.name)
                    .poppins("Poppins-Bold", 25)
                    .foregroundStyle(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(cast.character!)
                    .poppins("Poppins-Regular", 15)
                    .foregroundStyle(Color.white)
                    .fixedSize(horizontal: false, vertical: true)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 4)
          
        }
        
        .padding()
        .frame(width: 300, height: 170, alignment: .top)
        .background(Color.background)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.3), lineWidth: 1)
        )
       
    }
    
}

#Preview {
    CastCard(cast: DeveloperPreview.instance.cast)
}
