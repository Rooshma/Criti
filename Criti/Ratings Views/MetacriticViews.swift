//
//  MetacriticViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct MetacriticCondensedView: View {
    let movie: Movie
//    let ratingSource: RatingSource
    let formattedRating: String
    var fillColor: Color {
        switch movie.ratings[.metacritic]! {
            case 70...100: return .green
            case 40..<70: return .yellow
            case 0..<40: return .red
            default: return .gray
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(fillColor)
                .frame(width: 50, height: 50)
            if movie.ratings[.metacritic]! >= 0 {
                Text(formattedRating)
                    .font(.title2)
            } else {
                Text("N/A")
            }
        }
        .foregroundColor(.white)
    }
}

struct MetacriticExpandedView: View {
    var body: some View {
        Text("Hi")
    }
}

struct MetacriticInfoView: View {
    var body: some View {
        Text("Metacritic is...")
    }
}
