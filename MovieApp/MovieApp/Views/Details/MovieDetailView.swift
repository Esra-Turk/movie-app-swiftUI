//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import SwiftUI

enum DetailViewSection: String {
    case about = "About"
    case review = "Reviews"
    case cast = "Cast"
}

struct MovieDetailView: View {
    @StateObject private var viewModel: DetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    @Namespace private var namespace
    
    init(movie: Movie) {
        _viewModel = StateObject(wrappedValue: DetailsViewModel(movie: movie))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                headerSection
                Spacer()
                infoSection
                    .padding()
                    .padding(.top, contentOffset)
            }
            .preferredColorScheme(.dark)
            .background(Color.background)
            .task {
                await viewModel.fetchReviews()
            }
        }
        .background(Color.background.ignoresSafeArea())
    }
    
    private var headerSection: some View {
        ZStack(alignment: .leading) {
            ZStack(alignment: .top) {
                CustomImageView(movie: viewModel.movie, itemWidth: screenWidth, itemHeight: posterImageHeight)
                topBar
            }
            movieTitleSection
                .padding()
                .offset(y: backdropImageOffset)
        }
    }
    
    private var topBar: some View {
        HStack {
            Image("BackIcon")
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            Text("Detail")
            Spacer()
            Image("BookmarkIcon")
        }
        .padding()
        .background(Color.background)
    }
    
    private var movieTitleSection: some View {
        HStack {
            CustomImageView(movie: viewModel.movie, itemWidth: backdropImageHeight, itemHeight: backdropImageHeight, imageType: "backdrop")
            Text(viewModel.movie.title)
                .font(.title3)
                .fontWeight(.bold)
                .minimumScaleFactor(0.5)
                .padding(.top, titleOffset)
        }
    }
    
    private var infoSection: some View {
        VStack {
            movieInfo
            sectionTabs
            showContent()
            Spacer()
        }
    }
    
    private var movieInfo: some View {
        HStack {
            iconText(icon: "CalendarIcon", text: "2023")
            separator
            iconText(icon: "ClockIcon", text: "160 minutes")
            separator
            iconText(icon: "GenreIcon", text: "Action")
        }
        .frame(maxWidth: .infinity)
    }
    
    private var sectionTabs: some View {
        HStack {
            ForEach(viewModel.sections, id: \.self) { section in
                DetailSectionCard(section: section, namespace: namespace, selectedSection: $viewModel.selectedSection)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            viewModel.selectedSection = section
                        }
                    }
            }
        }
        
    }
    
    private func showContent() -> some View {
        Group {
            switch viewModel.selectedSection {
            case .about:
                Text(viewModel.movie.overview)
            case .review:
                ForEach(viewModel.reviews) { review in
                    ReviewCard(review: review)
                }
            case .cast:
                Text("cast")
            }
        }
        .transition(.opacity)
    }

    
    private func iconText(icon: String, text: String) -> some View {
        HStack {
            Image(icon)
            Text(text)
                .foregroundStyle(Color.gray2)
        }
    }
    
    private var separator: some View {
        Text("|")
            .foregroundStyle(Color.gray2)
    }
    
    private var posterImageHeight: CGFloat {
        screenHeight * 0.45
    }
    
    private var backdropImageHeight: CGFloat {
        screenHeight * 0.20
    }
    
    private var backdropImageOffset: CGFloat {
        screenHeight * 0.22
    }
    
    private var titleOffset: CGFloat {
        screenHeight * 0.10
    }
    
    private var contentOffset: CGFloat {
        screenHeight * 0.10
    }
}

#Preview {
    MovieDetailView(movie: DeveloperPreview.instance.movie)
}
