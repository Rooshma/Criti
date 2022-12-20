//
//  Movie.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-01.
//

import SwiftUI

struct Movie: Identifiable, Codable {
    var posterPath: String
    var description: String
    var id: Int
    var title: String
    var tmdbVoteAverage: Double
    var tmdbVoteCount: Int
    var imdbID = ""
    var length = ""
    var genres: [String] = []
    var ratings: [RatingSource: Double] = [.imdb: -1,
                                           .tmdb: -1,
                                           .rottenTomatoes: -1,
                                           .metacritic: -1,
                                           .letterboxd: -1]
    var ratingCounts: [RatingSource: Int] = [.imdb: 0,
                                             .tmdb: 0,
                                             .rottenTomatoes: 0,
                                             .metacritic: 0,
                                             .letterboxd: 0]
    
    static let example1 = Movie(posterPath: "https://www.themoviedb.org/t/p/w1280/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
                                description: """
                                            Feature adaptation of Frank Herbert's science fiction novel, about the son of a noble family entrusted with the protection of the most valuable asset and most vital element in the galaxy.
                                            """,
                                id: 123456789,
                                title: "Dune",
                                tmdbVoteAverage: 7.8,
                                tmdbVoteCount: 8029,
                                length: "156 mins",
                                ratings: [.imdb: 8.5, .rottenTomatoes: 90, .letterboxd: 4.2, .tmdb: 78])
    static let example2 = Movie(posterPath: "https://www.themoviedb.org/t/p/w1280/eEVaW9GubVYKV2IQNWY3yYF3TFa.jpg",
                                description: """
                                            Three years after Mike bowed out of the stripper life at the top of his game, he and the remaining Kings of Tampa hit the road to Myrtle Beach to put on one last blow-out performance.
                                            """,
                                id: 987654321,
                                title: "Magic Mike XXL",
                                tmdbVoteAverage: 10.0,
                                tmdbVoteCount: 1_000_000)
    //                                length: 115,
    //                                ratings: [RatingSource.imdb: 10, RatingSource.rottenTomatoes: 100, RatingSource.letterboxd: 5.0])
    
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case description = "overview"
        case id
        case title
        case tmdbVoteAverage = "vote_average"
        case tmdbVoteCount = "vote_count"
    }
}


