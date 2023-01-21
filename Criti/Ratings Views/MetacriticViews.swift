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
    let formattedRating: String
    
    var body: some View {
        VStack {
            Image(colorScheme == .light ? "mcLogoDark" : "mcLogoLight")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
            // midLogos alignment guide might be unnecessary now. Consider deleting.
                .alignmentGuide(.midLogos) { d in d[VerticalAlignment.center] }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(metacriticFillColor(for: movie.metacriticRating.criticRating))
                    .frame(width: 50, height: 50)
                if movie.metacriticRating.criticRating >= 0 {
                    Text(movie.metacriticRating.criticRating.formatted())
//                        .font(.custom("Arial", size: 25))
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
        VStack {
            
            HStack {
                Image(colorScheme == .light ? "mcLogoDark" : "mcLogoLight")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                Spacer()
            }
            .padding(.bottom)
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(metacriticFillColor(for: movie.metacriticRating.criticRating))
                        .frame(width: 50, height: 50)
                    movie.metacriticRating.criticRating >= 0 ? Text(movie.metacriticRating.criticRating.formatted()) : Text("tbd")
                }
                .font(.custom("Arial", size: 25))
                
                VStack(alignment: .leading) {
                    Group {
                        Text("METASCORE")
                            .padding(.bottom, 1)
                        Text(Metacritic.consensusPhrase(for: movie.metacriticRating.criticRating))
                        Text("Based on \(movie.metacriticRating.criticRatingCount) reviews")
                    }
                    .font(.custom("Arial", size: 15))
                }
            }
            
            Divider()
            
            HStack {
                ZStack {
                    Circle()
                        .fill(metacriticFillColor(for: movie.metacriticRating.audienceRating))
                        .frame(width: 50, height: 50)
                    movie.metacriticRating.audienceRating >= 0 ? Text(movie.metacriticRating.audienceRating.formatted()) : Text("tbd")
                }
                .font(.custom("Arial", size: 25))

                VStack(alignment: .leading) {
                    Group {
                        Text("USER SCORE")
                            .padding(.bottom, 1)
                        Text(Metacritic.consensusPhrase(for: movie.metacriticRating.criticRating))
                        Text("Based on \(movie.metacriticRating.audienceRatingCount) reviews")
                    }
                    .font(.custom("Arial", size: 15))
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

func metacriticFillColor(for rating: Int) -> Color {
    switch rating {
        case 60...100: return Color("MCGreen")
        case 40..<60: return Color("MCYellow")
        case 0..<40: return Color("MCRed")
        default: return Color("MCGray")
    }
}
