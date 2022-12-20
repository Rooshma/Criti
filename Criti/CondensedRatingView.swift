//
//  CondensedRatingView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-02.
//

import SwiftUI

struct CondensedRatingView: View {
    let movie: Movie
    let ratingSource: RatingSource
    var formattedRating: String {
        /// I feel like this is more complicated than it need be
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let rawRating = movie.ratings[ratingSource]
        return formatter.string(from: NSNumber(value: rawRating ?? 0.0)) ?? "Err"
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(ratingSource.rawValue)
                switch ratingSource {
                    case .tmdb:
                        ZStack {
                            Circle()
                            Circle()
                                .stroke(lineWidth: 3)
                                .foregroundColor(.gray)
                                .padding(5)
                            Circle()
                                .trim(from: 0, to: movie.ratings[ratingSource]! / 100)
                                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                .foregroundColor(movie.ratings[ratingSource]! > 70 ? .green : .red)
                                .padding(5)
                                .rotationEffect(.degrees(-90))
                            HStack(spacing: 0) {
                                if movie.ratings[ratingSource]! >= 0 {
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
                    case .imdb:
                        HStack (spacing: 5) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            VStack {
                                HStack(spacing: 3) {
                                    if movie.ratings[ratingSource]! >= 0 {
                                        Text(formattedRating)
                                            .font(.title)
                                        Text("/")
                                            .foregroundColor(.secondary)
                                        Text("10")
                                            .foregroundColor(.secondary)
                                    } else {
                                        Text("N/A")
                                            .foregroundColor(.secondary)
                                    }
                                }
                                if movie.ratingCounts[.imdb] ?? 0 > 0 {
                                    Text("\(movie.ratingCounts[.imdb] ?? 0) votes")
                                        .font(.caption2)
                                }
                            }
                        }
                    case .rottenTomatoes:
                        VStack {
                            HStack {
                                switch movie.ratings[ratingSource]! {
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
                                movie.ratings[ratingSource]! >= 0 ?
                                    Text(formattedRating + "%")
                                        .font(.title2) :
                                    Text("N/A")
                                        .font(.title3)
                                        .foregroundColor(.secondary)
                            }
                        }
                    case .metacritic:
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.green)
                                .frame(width: 50, height: 50)
                            Text(formattedRating)
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        
                    default:
                        Text("Hello, world")
                }
            }
            Spacer()
        }
    }
}

struct CondensedRatingView_Previews: PreviewProvider {
    static var previews: some View {
        CondensedRatingView(movie: Movie.example1, ratingSource: .rottenTomatoes)
    }
}
// 248 244 214
