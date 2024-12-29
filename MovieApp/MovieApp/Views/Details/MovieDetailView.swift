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
    case similar = "Similar"
}

struct MovieDetailView: View {
    @StateObject private var viewModel: DetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    @Namespace private var namespace
    @State private var isLiked: Bool = false
    @State private var isOnList : Bool = false
    private var watchlistViewModel: WatchlistViewModel = WatchlistViewModel()
    
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
                await viewModel.getMovieFirstGenre()
                await viewModel.getMovieVideo()
                await viewModel.getMovieCast()
                await viewModel.getSimilarMovies()
            }
        }
        .background(Color.background.ignoresSafeArea())
    }
    
    private var headerSection: some View {
        ZStack(alignment: .leading) {
            ZStack(alignment: .top) {
                CustomImageView(movie: viewModel.movie, itemWidth: screenWidth, itemHeight: posterImageHeight)
                topBar
                playButton
            }
            movieTitleSection
                .padding()
                .offset(y: backdropImageOffset)
        }
    }
    
    private var playButton : some View {
        if let videoURL = viewModel.getVideoURL() {
            return AnyView(Button(action: {
                openURL(videoURL)
        }) {
            Image("play")
                .resizable()
                .frame(width: 80, height: 80)
                .padding()
        }
        .frame(
            width: screenWidth,
            height: posterImageHeight,
            alignment: .center
        ))
            
        } else {
            //if there is no video remove play button
            return AnyView(EmptyView())
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
            Button(action: {
                Task {
                    await viewModel.addToFavorite()
                    isLiked = true
                }
               
            }) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 22, height: 20)
                    .foregroundStyle(isLiked ? .red : .white)
                    
            }
        }
        .padding()
        .background(Color.background)
    }
    
    private var movieTitleSection: some View {
        HStack {
            CustomImageView(movie: viewModel.movie, itemWidth: backdropImageHeight, itemHeight: backdropImageHeight, imageType: "backdrop")
            Text(viewModel.movie.title)
                .font(.title2)
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
            iconText(icon: "CalendarIcon", text: viewModel.movie.releaseYear)
            separator
            iconText(icon: "Star", text: "\(viewModel.movie.voteMovie) (IMDb)")
            separator
            iconText(icon: "GenreIcon", text: viewModel.movieGenre?.name ?? "No genre")
            Button {
                Task {
                    await watchlistViewModel.updateWatchlist(movie: viewModel.movie, addToWatchlist: true)
                }
                isOnList = true
              
            } label: {
                Image(isOnList ? "BookmarkIcon": "bookmark")
                    .frame(alignment: .leading)
                    .offset(x : 10)
            }
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
                HScrollView(items: viewModel.cast) { cast in
                    CastCard(cast: cast)
                }
            case .similar:
                MovieGridView(items: viewModel.similarMovies) { movie in
                    MovieCard(movie: movie, type: .grid )
                }
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
