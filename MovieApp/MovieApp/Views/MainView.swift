//
//  MainView.swift
//  MovieApp
//
//  Created by Esra Türk on 20.12.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
    
            HomeView()
                .tabItem() {
                    Label("Home", systemImage: "play.rectangle")
                }
               
            FavoritesView()
                .tabItem() {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            WatchlistView()
                .tabItem() {
                    Label("Watchlist", systemImage: "list.star")
                }
        }
        .tint(.white)
    }
}

#Preview {
    MainView()
}
