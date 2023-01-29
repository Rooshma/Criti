//
//  TMDbViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct TMDbCondensedView: View {
    let movie: Movie
    var fillColor: Color {
        switch movie.tmdbRating.audienceRating {
            case 70 ... 100: return Color("TMDbGreen")
            case 40 ..< 70: return Color("TMDbYellow")
            case 0 ..< 40: return Color("TMDbRed")
            default: return Color("TMDbGray")
        }
    }
    
    var body: some View {
        VStack {
            Image("tmdbLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
            ZStack {
                Circle()
                    .fill(Color("TMDbDarkBackground"))
                Circle()
                    .stroke(lineWidth: 3)
                    .foregroundColor(.gray)
                    .padding(5)
                Circle()
                    .trim(from: 0, to: movie.tmdbRating.audienceRating / 100)
                    .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                    .foregroundColor(fillColor)
                    .padding(5)
                    .rotationEffect(.degrees(-90))
                HStack(spacing: 0) {
                    if movie.tmdbRating.audienceRating >= 0 {
                        Text("\(movie.tmdbRating.audienceRating.formatted())")
                            .font(.callout)
                        Text("%")
                            .font(.caption2)
                            .padding(.bottom, 5.0)
                    } else { Text("N/A") }
                }
                .foregroundColor(.white)
            }
            .frame(width: 55, height: 55)
        }
    }
}

struct TMDbExpandedView: View {
    var body: some View {
        Text("Hi")
    }
}

struct TMDbInfoView: View {
    var body: some View {
        VStack {
            Image("tmdbLogo")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        }
        .padding(.horizontal)
    }
}
