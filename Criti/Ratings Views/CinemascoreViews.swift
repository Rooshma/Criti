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
        VStack {
            Image("csLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
                .alignmentGuide(.midLogos) { d in d[VerticalAlignment.center] }
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [Color("CinemascoreGradientDark"),
                                                  Color("CinemascoreGradientLight")],
                                         startPoint: .bottomLeading,
                                         endPoint: .topTrailing))
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
}

struct CinemascoreInfoView: View {
    var body: some View {
        VStack {
            Image("csLogo")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            Text("""
For over 40 years, CinemaScore has been measuring movie appeal by polling moviegoer reactions to major movie releases. The company calculates its “CinemaScore” movie grades for major movie releases in the U.S. and Canada by polling a regionally-balanced and statistically robust sample of opening night moviegoers.\n\nA movie’s overall CinemaScore can range from A+ to F. Each opening weekend, CinemaScore polls moviegoers directly at theatres across North America, including Canada. Pollsters provide audience members a ballot with six questions—including an A to F grade scale, purchase and rental interest and demographic data. To answer these questions, moviegoers bend back tabs on the CinemaScore ballot (instead of having to use a pen or pencil to fill out a questionnaire or survey). After the movie ends, audience members return their ballots to CinemaScore’s pollsters, who tabulate the data and send the results immediately to CinemaScore.
""")
        }
        .padding(.horizontal)
    }
}
