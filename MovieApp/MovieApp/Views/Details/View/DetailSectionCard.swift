//
//  DetailSectionCard.swift
//  MovieApp
//
//  Created by Esra Türk on 16.12.2024.
//

import SwiftUI

struct DetailSectionCard: View {
    let section : DetailViewSection
    let namespace : Namespace.ID
    @Binding var selectedSection : DetailViewSection
    
    var body: some View {
        Text(section.rawValue).poppins("Poppins-Regular", 16)
            .background(
                ZStack {
                    if section == selectedSection {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 4)
                            .offset(y: 20)
                            .matchedGeometryEffect(id: "DetailSectionCard", in: namespace)
                    }
                }
            )
            .padding()
    }
}

#Preview {
    DetailSectionCard(section: .about, namespace: Namespace().wrappedValue, selectedSection: .constant(.about))
}
