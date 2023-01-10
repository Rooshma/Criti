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

struct RottenTomatoesInfoView: View {
    var body: some View {
        VStack {
            Image("rtLogo")
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


struct Previews_RottenTomatoesViews_Previews: PreviewProvider {
    static var previews: some View {
        RottenTomatoesInfoView()
    }
}
