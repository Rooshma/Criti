//
//  CinemascoreViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct CinemascoreCondensedView: View {
    let movie: Movie
    var letterGrade: String { Cinemascore.SearchResponse.numbersToLetters[movie.ratings[.cinemascore]!]! }
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Rectangle()
                    .fill(LinearGradient(colors: [Color("CinemascoreGradientDark"),
                                                  Color("CinemascoreGradientLight")],
                                         startPoint: .bottomLeading,
                                         endPoint: .topTrailing))
            }
            Text(letterGrade)
                .font(.custom("Baskerville", size: 30))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                .padding(5)
                .foregroundColor(.white)
        }
        .frame(width: 50, height: 50)
    }
}
