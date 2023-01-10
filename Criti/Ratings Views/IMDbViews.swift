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

struct IMDbInfoView: View {
    var body: some View {
        VStack {
            Image("imdbLogo")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            Divider()
            HStack {
                Image("rtCriticsFreshIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Text("Fresh means...")
            }
            Divider()
            HStack {
                Image("rtCriticsRottenIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Text("Rotten means...")
            }
        }
        .padding(.horizontal)
    }
}
