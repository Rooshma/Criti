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
    var fillColor: Color {
        switch movie.ratings[.metacritic]! {
            case 70...100: return Color("MCGreen")
            case 40..<70: return Color("MCYellow")
            case 0..<40: return Color("MCRed")
            default: return Color("MCGray")
        }
    }
    
    var body: some View {
        VStack {
            Image(colorScheme == .light ? "mcLogoDark" : "mcLogoLight")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
                .alignmentGuide(.midLogos) { d in d[VerticalAlignment.center] }
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(fillColor)
                    .frame(width: 50, height: 50)
                if movie.ratings[.metacritic]! >= 0 {
                    Text(formattedRating)
                        .font(.custom("Arial", size: 25))
                } else {
                    Text("N/A")
                }
            }
            .foregroundColor(.white)
        }
    }
}

struct MetacriticExpandedView: View {
    var body: some View {
        Text("Hi")
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
