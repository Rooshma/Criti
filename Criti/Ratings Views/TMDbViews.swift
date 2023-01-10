//
//  TMDbViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct TMDbCondensedView: View {
    let movie: Movie
    let formattedRating: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.black)
            Circle()
                .stroke(lineWidth: 3)
                .foregroundColor(.gray)
                .padding(5)
            Circle()
                .trim(from: 0, to: movie.ratings[.tmdb]! / 100)
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .foregroundColor(movie.ratings[.tmdb]! >= 70 ? .green : movie.ratings[.tmdb]! >= 40 ? .yellow : .red)
                .padding(5)
                .rotationEffect(.degrees(-90))
            HStack(spacing: 0) {
                if movie.ratings[.tmdb]! >= 0 {
                    Text("\(formattedRating)")
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

struct TMDbExpandedView: View {
    var body: some View {
        Text("Hi")
    }
}

struct TMDbInfoView: View {
    var body: some View {
        Text("TMDb is...")
    }
}
