//
//  HomeView.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                Text("Movie App")
                    .font(.largeTitle)
                    .bold()
                
                SearchBar(searchText: $searchText)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1..<5, id: \.self) { _ in
                            MovieCard(movie: DeveloperPreview.instance.movie)
                        }
                    }
                   
                }
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(1..<10, id: \.self){ _ in
                        MovieCard(movie: DeveloperPreview.instance.movie, type: .grid)}
                }
              
            }
        }
        .preferredColorScheme(.dark)
        .padding()
        .background(Color.background)
    }
}

#Preview {
    HomeView()
}
