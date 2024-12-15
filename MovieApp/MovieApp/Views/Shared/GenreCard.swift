//
//  GenreCard.swift
//  MovieApp
//
//  Created by Esra Türk on 15.12.2024.
//

import SwiftUI

struct GenreCard: View {
    let genre: Genre
    let namespace : Namespace.ID
    @Binding var selectedGenre : Genre
    
    var body: some View {
        Text(genre.name)
            .poppins(genre.id == selectedGenre.id ? "Poppins-Bold" : "Poppins-Regular", 18)
            .background(
                ZStack {
                    if selectedGenre.id == genre.id {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray1)
                            .frame(height : 3)
                            .offset(y : 20)
                            .matchedGeometryEffect(id: "GenreCard", in: namespace)
                            
                    }
                }
            )
            .padding()
    }
}

#Preview {
    let preview = DeveloperPreview.instance
    GenreCard(genre : preview.genre, namespace: Namespace().wrappedValue, selectedGenre: .constant(preview.genre))
}
