//
//  CinemascoreViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct CinemascoreCondensedView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            Image("csLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
            CinemascoreLetterGradeView(movie: movie)
        }
    }
}

struct CinemascoreExpandedView: View {
    let movie: Movie
    
    var body: some View {
        VStack {
            HStack {
                Image("csLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                Spacer()
            }
            .padding(.bottom, 5)
            
            HStack {
                CinemascoreLetterGradeView(movie: movie)
                if let exampleMovies = Cinemascore.exampleMovies[movie.cinemascoreRating]?.formatted(.list(type: .and)) {
                    Text("Other movies with this score include\n\(exampleMovies)")
                        .font(.caption)
                        .frame(maxHeight: .infinity)
                        .padding(.leading, 5)
                }
            }
        }
        .padding()
    }
}

struct CinemascoreLetterGradeView: View {
    let movie: Movie

    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [Color("CinemascoreGradientDark"),
                                              Color("CinemascoreGradientLight")],
                                     startPoint: .bottomLeading,
                                     endPoint: .topTrailing))
            Text(movie.cinemascoreRating)
                .font(.custom("Baskerville", size: 30))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                .padding(5)
                .foregroundColor(.white)
        }
        .frame(width: 50, height: 50)
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
