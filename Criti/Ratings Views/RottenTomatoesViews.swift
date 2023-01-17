//
//  RottenTomatoesViews.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import SwiftUI

struct RottenTomatoesCondensedView: View {
    let movie: Movie
//    let formattedRating: String
    
    var body: some View {
        VStack {
            Image("rtLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 75)
                .alignmentGuide(.midLogos) { d in d[VerticalAlignment.center] }
            RottenTomatoesRatingIcon(rating: movie.rottenTomatoesRating.criticRating, type: .critic)
        }
    }
}

struct RottenTomatoesExpandedView: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("rtLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 20)
            HStack {
                RottenTomatoesRatingIcon(rating: movie.rottenTomatoesRating.criticRating, type: .critic)
                VStack(alignment: .leading) {
                    Text("Critics consensus:")
                        .bold()
                    Text(movie.rottenTomatoesRating.criticConsensus)
                }
                .font(.caption)
            }
            Divider()
            HStack {
                RottenTomatoesRatingIcon(rating: movie.rottenTomatoesRating.audienceRating, type: .audience)
                VStack(alignment: .leading) {
                    Text("Audience consensus:")
                        .bold()
                    Text(movie.rottenTomatoesRating.audienceConsensus)
                }
                .font(.caption)
            }
        }
        .padding()
    }
}

struct RottenTomatoesRatingIcon: View {
    let rating: Int
    let type: RottenTomatoes.RatingType
    var icon: String {
        switch type {
            case .critic:
                switch rating {
                    case 0..<60: return "rtCriticsRottenIcon"
                    case 60...100: return "rtCriticsFreshIcon"
                    default: return "rtCriticsEmptyIcon"
                }
            case .audience:
                switch rating {
                    case 0..<60: return "rtAudienceRottenIcon"
                    case 60...100: return "rtAudienceFreshIcon"
                    default: return "rtAudienceEmptyIcon"
                }
        }
    }
    
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            rating >= 0 ?
            Text("\(rating.formatted())" + "%")
                .font(.title2) :
            Text("N/A")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
}

struct RottenTomatoesInfoView: View {
    var body: some View {
        VStack {
            Image("rtLogo")
                .resizable()
                .scaledToFit()
                .padding(.bottom)
            Text("The Tomatometer rating – based on the published opinions of hundreds of film and television critics – is a trusted measurement of movie and TV programming quality for millions of moviegoers. It represents the percentage of professional critic reviews that are positive for a given film or television show.")
            Divider()
            HStack {
                Image("rtCriticsFreshIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Text("Fresh means that more than 60% of critics reviewed a film positively.")
            }
            Divider()
            HStack {
                Image("rtCriticsRottenIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Text("Rotten means that less than 60% of critics reviewed a film positively.")
            }
        }
        .padding(.horizontal)
    }
}
