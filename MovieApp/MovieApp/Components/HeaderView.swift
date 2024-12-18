//
//  Components.swift
//  MovieApp
//
//  Created by Esra Türk on 18.12.2024.
//

import SwiftUI

struct HeaderView: View {
    var title : String
    var size : CGFloat
   
    var body: some View {
        Text(title)
            .poppins("Poppins-Bold", size)
    }
}
