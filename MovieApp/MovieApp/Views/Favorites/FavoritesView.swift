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
                
                
            }
        }
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.background)
        .task {
            await viewmodel.getFavorites()
        }
    }
}

#Preview {
    FavoritesView()
}
