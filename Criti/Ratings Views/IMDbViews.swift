//
//  IMDbViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct IMDbCondensedView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            Image("imdbLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 60)
            HStack (spacing: 5) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                VStack {
                    HStack(spacing: 3) {
                        if movie.imdbRating.averageRating >= 0 {
                            Text(movie.imdbRating.averageRating.formatted())
                                .font(.title2)
                            Group {
                                Text("/")
                                Text("10")
                            }
                            .font(.callout)
                            .foregroundColor(.secondary)
                        } else {
                            Text("N/A")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}

struct IMDbExpandedView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("imdbLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                Spacer()
                if let pageURL = IMDb.pageURL(for: movie) {
                    Link(destination: pageURL) {
                        Image(systemName: "link")
                    }
                }
            }
            Grid() {
                GridRow {
                    Group {
                        Spacer()
                        Text("All Ages")
                        Text("<18")
                        Text("18-29")
                        Text("30-44")
                        Text("45+")
                    }
                    .font(.caption)
                }
                Divider()
                GridRow {
                    Text("All")
                        .font(.caption)
                    ForEach(movie.imdbRating.allUserRatings, id: \.self) { rating in
                        Text("\(rating.formatted())")
                    }
                }
                Divider()
                GridRow {
                    Text("Males")
                        .font(.caption)
                    ForEach(movie.imdbRating.maleUserRatings, id: \.self) { rating in
                        Text("\(rating.formatted())")
                    }
                }
                Divider()
                GridRow {
                    Text("Females")
                        .font(.caption)
                    ForEach(movie.imdbRating.femaleUserRatings, id: \.self) { rating in
                        Text("\(rating.formatted())")
                    }
                }
            }
//            .padding(.horizontal, 3)
        }
        .padding()
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
        }
        .padding(.horizontal)
    }
}
