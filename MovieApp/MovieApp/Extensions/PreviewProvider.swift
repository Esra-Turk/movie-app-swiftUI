//
//  PreviewProvider.swift
//  MovieApp
//
//  Created by Esra Türk on 13.12.2024.
//

import SwiftUI

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let movie = Movie(adult: false, backdropPath: "/3V4kLQg0kSqPLctI5ziYWabAZYF.jpg", genreIDS: [1], id: 912649, originalLanguage: "", originalTitle: "", overview: "", popularity: 10.0, posterPath: "/aosm8NMQ3UyoBVpSxyimorCQykC.jpg", releaseDate: "2024-10-25", title: "Venom: The Last Dance", video: false, voteAverage: 10.0, voteCount: 1)
    
    let genre = Genre(id: 28, name: "Action")
    let authorDetail = AuthorDetails(name: "", username: "Goddard", avatarPath: "/https://secure.gravatar.com/avatar/f248ec34f953bc62cafcbdd81fddd6b6.jpg", rating: nil)
    
    lazy var review = Review(author: "Goddard", authorDetails: authorDetail, content: "Pretty awesome movie.  It shows what one crazy person can convince other crazy people to do.  Everyone needs something to believe in.  I recommend Jesus Christ, but they want Tyler Durden.", createdAt: "2018-06-09T17:51:53.359Z", id: "5b1c13b9c3a36848f2026384", updatedAt: "2021-06-23T15:58:09.421Z", url: "https://www.themoviedb.org/review/5b1c13b9c3a36848f2026384")
    


}
