//
//  IMDbViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct IMDbCondensedView: View {
    let movie: Movie
    let formattedRating: String
    
    var body: some View {
        HStack (spacing: 5) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            VStack {
                HStack(spacing: 3) {
                    if movie.ratings[.imdb]! >= 0 {
                        Text(formattedRating)
                            .font(.title)
                        Text("/")
                            .foregroundColor(.secondary)
                        Text("10")
                            .foregroundColor(.secondary)
                    } else {
                        Text("N/A")
                            .foregroundColor(.secondary)
                    }
                }
                if movie.ratingCounts[.imdb] ?? 0 > 0 {
                    Text("\(movie.ratingCounts[.imdb] ?? 0) votes")
                        .font(.caption2)
                }
            }
        }
    }
}

struct IMDbExpandedView: View {
    var body: some View {
        Text("Hi")
    }
}

