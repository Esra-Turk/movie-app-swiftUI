//
//  DetailsViewModel.swift
//  MovieApp
//
//  Created by Esra Türk on 11.12.2024.
//

import Foundation

@MainActor
class DetailsViewModel : ObservableObject {
    let movie : Movie
    let sections : [DetailViewSection] = [.about,.review, .cast]
    @Published var selectedSection : DetailViewSection = .about
    @Published var reviews : [Review] = []
    @Published var genres : [Genre] = []
    @Published var movieGenre : Genre?
    @Published var movieVideo: [Video] = []
    @Published var cast : [Cast] = []
   
    private let movieService = MovieService()
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchReviews() async {
        do {
            let response : ReviewResponse = try await movieService.fetchData(api: ApiConstructor(endpoint: .movieReview(movie.id)))
            reviews = response.results
        } catch {
            print("Error : \(error.localizedDescription)")
        }
    }
    
    func getMovieFirstGenre() async {
        do {
            let response : GenreResponse = try await movieService.fetchData(api: ApiConstructor(endpoint: .genre))
            genres = response.genres
            
            if let firstID = movie.genreIDS.first {
                movieGenre = genres.first(where: { $0.id == firstID })
            }
            
        } catch {
            print("Error : \(error.localizedDescription)")
        }
        
    }
    
    func getMovieVideo() async {
        do {
             let response: VideoResponse = try await movieService.fetchData(api: ApiConstructor(endpoint: .watchTrailer(movie.id)))
             movieVideo = response.results
         } catch {
             print(String(describing: error))
           
         }
    }
    
    func getMovieCast() async {
        do {
            let response : CastResponse = try await movieService.fetchData(api: ApiConstructor(endpoint: .movieCredits(movie.id)))
            cast = response.cast
        } catch {
            print("Error : \(error.localizedDescription)")
        }
    }
}

extension DetailsViewModel {
    static let preferredTypes: [TypeEnum] = [.trailer, .teaser, .featurette, .clip]
    
    func getVideoURL() -> URL? {
        for type in DetailsViewModel.preferredTypes {
            if let video = movieVideo.first(where: { $0.type == type }) {
                return video.youtubeURL
            }
        }
        
        return nil
    }
}

