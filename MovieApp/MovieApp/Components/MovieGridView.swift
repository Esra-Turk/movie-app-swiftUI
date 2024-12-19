//
//  MovieGridView.swift
//  MovieApp
//
//  Created by Esra Türk on 18.12.2024.
//

import SwiftUI

struct MovieGridView<Item: Identifiable, Content: View>: View {
    var items: [Item]
    var content: (Item) -> Content

    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(items, content: content)
        }
    }
}
