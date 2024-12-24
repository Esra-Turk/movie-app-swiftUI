//
//  SearchBar.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        TextField("Search", text: $searchText)
            .overlay(
                ZStack {
                    Image(systemName: "xmark")
                        .foregroundStyle(Color.white)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    
                    Image("SearchIcon")
                        .opacity(searchText.isEmpty ? 1 : 0)
                },
                alignment: .trailing
            )
            .foregroundStyle(Color.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray1)
            )
    }
}

#Preview {
    SearchBar(searchText: .constant(""))
}
