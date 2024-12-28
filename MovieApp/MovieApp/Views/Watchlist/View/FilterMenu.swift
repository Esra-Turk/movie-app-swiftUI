//
//  FilterMenu.swift
//  MovieApp
//
//  Created by Esra Türk on 28.12.2024.
//

import SwiftUI

struct FilterMenu: View {
    @State private var selectedFilter: String = "Popularity"

    var body: some View {
        HStack {
            Text("Filter by:")
                .poppins("Poppins-Regular",18)
            
            Menu {
                Button ("Popularity", action: { selectedFilter = "Popularity" })
                Button("Upcoming", action: { selectedFilter = "Upcoming" })
                Button("Added Date", action: { selectedFilter = "Added Date" })
                Button("Release Date", action: { selectedFilter = "Release Date" })
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

#Preview {
    FilterMenu()
}
