//
//  CondensedRatingView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-02.
//

import SwiftUI

struct CondensedRatingView: View {
    let movie: Movie
    let ratingSource: RatingSource
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .opacity(0.15)
            switch ratingSource {
                case .tmdb: TMDbCondensedView(movie: movie)
                case .imdb: IMDbCondensedView(movie: movie)
                case .rottenTomatoes: RottenTomatoesCondensedView(movie: movie)
                case .metacritic: MetacriticCondensedView(movie: movie)
                case .cinemascore: CinemascoreCondensedView(movie: movie)
                case .letterboxd: LetterboxdCondensedView(movie: movie)
//                default:
//                    Text("Error")
            }
        }
        .frame(width: 90, height: 90)
    }
}

//struct CondensedRatingView_Previews: PreviewProvider {
//    static var previews: some View {
//        CondensedRatingView(movie: Movie.example1, ratingSource: .cinemascore)
//    }
//}
