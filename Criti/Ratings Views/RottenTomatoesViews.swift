//
//  RottenTomatoesViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct RottenTomatoesCondensedView: View {
    let movie: Movie
    let formattedRating: String
    
    var body: some View {
        VStack {
            HStack {
                switch movie.ratings[.rottenTomatoes]! {
                    case 0..<60:
                        Image("rtCriticsRottenIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    case 60...100:
                        Image("rtCriticsFreshIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    default:
                        Image("rtCriticsEmptyIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                }
                movie.ratings[.rottenTomatoes]! >= 0 ?
                    Text(formattedRating + "%")
                        .font(.title2) :
                    Text("N/A")
                        .font(.title3)
                        .foregroundColor(.secondary)
            }
        }
    }
}

struct RottenTomatoesExpandedView: View {
    var body: some View {
        Text("Hi")
    }
}
