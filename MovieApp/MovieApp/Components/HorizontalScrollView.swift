//
//  HorizontalScrollView.swift
//  MovieApp
//
//  Created by Esra Türk on 18.12.2024.
//

import SwiftUI

struct HScrollView<Item: Identifiable, Content: View>: View {
    var items: [Item]
    var content: (Item) -> Content

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(items, content: content)
            }
        }
    }
}
