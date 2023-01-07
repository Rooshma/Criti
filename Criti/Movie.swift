//
//  Movie.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-01.
//

import SwiftUI

struct Movie: Identifiable, Codable {
    var posterPath: String! = ""
    var description: String = "No description available"
    var id: Int = -1
    var title: String = "Unknown title"
    var tmdbVoteAverage: Double = -1
    var tmdbVoteCount: Int = -1
    var imdbID: String = ""
    var length: String = "Unknown length"
    var genres: [String] = []
    
    var tmdbRating = TMDbRating()
    var imdbRating = IMDbRating()
    var rottenTomatoesRating = RottenTomatoesRating()
    var metacriticRating = MetacriticRating()
    var cinemascoreRating = CinemaScoreRating()
    
    //  THIS IS A PROBLEM! JSON DECODING STILL FAILS WHEN THERE'S NO DATE
    var releaseDate: Date?
    var wrappedReleaseDate: Date {
        if releaseDate != nil {
            return releaseDate!
        } else { return Date.distantPast }
    }
    
    var ratings: [RatingSource: Double] = [.imdb: -1,
                                           .tmdb: -1,
                                           .rottenTomatoes: -1,
                                           .metacritic: -1,
                                           .letterboxd: -1,
                                           .cinemascore: -1]
    var ratingCounts: [RatingSource: Int] = [.imdb: 0,
                                             .tmdb: 0,
                                             .rottenTomatoes: 0,
                                             .metacritic: 0,
                                             .letterboxd: 0]
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case description = "overview"
        case id
        case title
        case tmdbVoteAverage = "vote_average"
        case tmdbVoteCount = "vote_count"
        case releaseDate = "release_date"
    }
    
    struct TMDbRating: Codable {
        var audienceRating: Double = -1
        var audienceRatingCount: Int = -1
    }
    
    struct RottenTomatoesRating: Codable {
        var criticRating: Int = -1
        var criticRatingCount: Int = -1
        var audienceRating: Int = -1
        var audienceRatingCount: Int = -1
        var criticConsensus: String = ""
        var audienceConsensus: String = ""
    }
    
    struct IMDbRating: Codable {
        var averageRating: Int = -1
        var ratingCount: Int = -1
        /// IMDb does show rating histogram overall, and broken down for different demos. Could be something to look into.
    }
    
    struct MetacriticRating: Codable {
        var criticRating: Int = -1
        var criticRatingCount: Int = -1
        var audienceRating: Int = -1
        var audienceRatingCount: Double = -1
    }
    
    struct CinemaScoreRating: Codable {
        var audienceRating: String = ""
    }
    
    static let example1 = Movie(posterPath: "https://www.themoviedb.org/t/p/w1280/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
                                description: """
                                            Feature adaptation of Frank Herbert's science fiction novel, about the son of a noble family entrusted with the protection of the most valuable asset and most vital element in the galaxy.
                                            """,
                                id: 123456789,
                                title: "Dune",
                                tmdbVoteAverage: 7.8,
                                tmdbVoteCount: 8029,
                                length: "156 mins",
                                ratings: [.imdb: 8.5, .rottenTomatoes: 90, .letterboxd: 4.2, .tmdb: 78, .cinemascore: 8])
}


