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
        HStack {
            Spacer()
            VStack {
                Text(ratingSource.rawValue)
                    .font(.footnote)
                Spacer()
                switch ratingSource {
                    case .tmdb: TMDbCondensedView(movie: movie, formattedRating: formattedRating)
                    case .imdb: IMDbCondensedView(movie: movie, formattedRating: formattedRating)
                    case .rottenTomatoes: RottenTomatoesCondensedView(movie: movie, formattedRating: formattedRating)
                    case .metacritic: MetacriticCondensedView(movie: movie, formattedRating: formattedRating)
                    case .cinemascore: CinemascoreCondensedView(movie: movie)
                    default:
                        Text("Error")
                }
                Spacer()
            }
            Spacer()
        }
    }
}

//struct CondensedRatingView_Previews: PreviewProvider {
//    static var previews: some View {
//        CondensedRatingView(movie: Movie.example1, ratingSource: .cinemascore)
//    }
//}
