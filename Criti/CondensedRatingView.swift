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
    var formattedRating: String { movie.ratings[ratingSource]!.formatted() }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .opacity(0.15)
//            HStack {
//                Spacer()
//                VStack {
//                    Spacer()
                    switch ratingSource {
                        case .tmdb: TMDbCondensedView(movie: movie, formattedRating: formattedRating)
                        case .imdb: IMDbCondensedView(movie: movie, formattedRating: formattedRating)
                        case .rottenTomatoes: RottenTomatoesCondensedView(movie: movie)
                        case .metacritic: MetacriticCondensedView(movie: movie, formattedRating: formattedRating)
                        case .cinemascore: CinemascoreCondensedView(movie: movie)
                        case .letterboxd: LetterboxdCondensedView(movie: movie)
                        default:
                            Text("Error")
//                    }
//                    Spacer()
//                }
//                Spacer()
            }
        }
        .frame(width: 100, height: 150)
    }
}

//struct CondensedRatingView_Previews: PreviewProvider {
//    static var previews: some View {
//        CondensedRatingView(movie: Movie.example1, ratingSource: .cinemascore)
//    }
//}
