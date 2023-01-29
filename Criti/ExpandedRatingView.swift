//
//  ExpandedRatingView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-20.
//

import SwiftUI

struct ExpandedRatingView: View {
    let movie: Movie
    let ratingSource: RatingSource
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .opacity(0.15)
            switch ratingSource {
                case .tmdb: TMDbExpandedView()
                case .imdb: IMDbExpandedView(movie: movie)
                case .rottenTomatoes: RottenTomatoesExpandedView(movie: movie)
                case .metacritic: MetacriticExpandedView(movie: movie)
                case .cinemascore: CinemascoreExpandedView(movie: movie)
                case .letterboxd: LetterboxdExpandedView(movie: movie)
//                default:
//                    Text("Error")
            }
        }
    }
}
