//
//  FilterMenu.swift
//  MovieApp
//
//  Created by Esra Türk on 28.12.2024.
//

import SwiftUI

struct FilterMenu: View {
    @State private var selectedFilter: String = "Popularity"
    @StateObject var watchListVM: WatchlistViewModel

    var body: some View {
        HStack {
            Text("Filter by:")
                .poppins("Poppins-Regular",18)
            
            Menu {
                Button ("Popularity", action: {
                    selectedFilter = "Popularity"
                    watchListVM.filterByPopularity()
                })
                
                Button("Vote Avarage", action: {
                    selectedFilter = "Vote"
                    watchListVM.filterByVote()
                })
                
                Button("Release Date", action: {
                    selectedFilter = "Release"
                    watchListVM.filterByReleaseDate()
                })
                
            } label: {
                HStack {
                    Text(selectedFilter)
                        .foregroundColor(.green)
                    Image(systemName: "chevron.down")
                        .foregroundColor(.green)
                }
                .poppins("Poppins-Regular",18)
                .underline()
            }
        }
        
    }
}

