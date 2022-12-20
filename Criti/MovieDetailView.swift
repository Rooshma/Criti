//
//  MovieDetailView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-01.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        HStack {
                            ForEach(movie.genres, id: \.self) { genre in
                                Text(genre)
                            }
                            /// Ultimately I think this would be good, but TMDB doesn't send length back with recent releases.
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
                    // TODO: FIX POSTER VERTICAL ALIGNMENT
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath)")) { image in
                        image.resizable()
                    } placeholder: { Color.gray }
                        .scaledToFit()
                        .frame(width: 100, height: 200)
                }
            }
            .navigationTitle(movie.title)
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.example1)
    }
}
