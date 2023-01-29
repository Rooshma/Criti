//
//  MetacriticViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct MetacriticCondensedView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let movie: Movie
    
    var body: some View {
        VStack {
            Image(colorScheme == .light ? "mcLogoDark" : "mcLogoLight")
                .resizable()
                .scaledToFit()
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(Metacritic.fillColor(for: movie.metacriticRating.criticRating)))
                    .frame(width: 50, height: 50)
                if movie.metacriticRating.criticRating >= 0 {
                    Text(movie.metacriticRating.criticRating.formatted())
                } else {
                    Text("tbd")
                }
            }
            .foregroundColor(.white)
            .font(.custom("Arial", size: 25))
        }
        .padding()
    }
}

struct MetacriticExpandedView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image(colorScheme == .light ? "mcLogoDark" : "mcLogoLight")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                Spacer()
                if let pageURL = Metacritic.pageURL(for: movie) {
                    Link(destination: pageURL) {
                        Image(systemName: "link")
                    }
                }
            }
            .padding(.bottom)
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(Metacritic.fillColor(for: movie.metacriticRating.criticRating)))
                        .frame(width: 50, height: 50)
                    movie.metacriticRating.criticRating >= 0 ? Text(movie.metacriticRating.criticRating.formatted()) : Text("tbd")
                }
                .font(.custom("Arial", size: 25))
                .padding(.horizontal)

                VStack(alignment: .leading) {
                    Group {
                        Text("METASCORE")
                            .fontWeight(.bold)
                            .padding(.bottom, 1)
                        Text(Metacritic.consensusPhrase(for: movie.metacriticRating.criticRating))
                        Text("Based on \(movie.metacriticRating.criticRatingCount) reviews")
                    }
                    .font(.custom("Arial", size: 14))
                }
            }
            
            Divider()
            
            HStack {
                ZStack {
                    Circle()
                        .fill(Color(Metacritic.fillColor(for: movie.metacriticRating.audienceRating)))
                        .frame(width: 50, height: 50)
                    movie.metacriticRating.audienceRating >= 0 ? Text(movie.metacriticRating.audienceRatingOutOfTen.formatted()) : Text("tbd")
                }
                .font(.custom("Arial", size: 25))
                .padding(.horizontal)

                VStack(alignment: .leading) {
                    Group {
                        Text("USER SCORE")
                            .fontWeight(.bold)
                            .padding(.bottom, 1)
                        Text(Metacritic.consensusPhrase(for: movie.metacriticRating.criticRating))
                        Text("Based on \(movie.metacriticRating.audienceRatingCount) reviews")
                    }
                    .font(.custom("Arial", size: 14))
                }
            }
        }
        .padding()
    }
}

struct MetacriticInfoView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Image(colorScheme == .light ? "mcLogoDark" : "mcLogoLight")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        }
        .padding(.horizontal)
    }
}
