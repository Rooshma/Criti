//
//  MovieDetailView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-01.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    let ratingSources: [RatingSource] = [.imdb, .rottenTomatoes, .letterboxd, .cinemascore, .metacritic]
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        HStack {
                            ForEach(movie.genres, id: \.self) { genre in
                                Text(genre)
                            }
                            Text(movie.length)
                        }
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        Text(movie.description)
                            .font(.callout)
                            .padding(.top, 5.0)
                    }
                    Spacer()
                    // TODO: FIX POSTER VERTICAL ALIGNMENT?
                    PosterView(movie: movie)
                        .frame(width: 100)
                }
                ForEach(ratingSources, id: \.self) { ratingSource in
                    ExpandedRatingView(movie: movie, ratingSource: ratingSource)
                }
            }
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView(movie: Movie.example1)
//    }
//}
