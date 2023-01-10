//
//  Movie.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-01.
//

import SwiftUI

struct Movie: Identifiable, Codable {
    var id: Int = -1
    var imdbID: String = ""
    var title: String = "Unknown title"
    var description: String = "No description available"
    var length: String = "Unknown length"
    var genres: [String] = []
    var posterPath: String! = ""
    
    var releaseDate: Date?
        var wrappedReleaseDate: String {
            if let nonNilDate = releaseDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                dateFormatter.dateStyle = .long
                return dateFormatter.string(from: nonNilDate)
            } else { return "Unknown release date" }
        }
        var wrappedReleaseYear: String {
            if let nonNilDate = releaseDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy"
                return dateFormatter.string(from: nonNilDate)
            } else { return "Unknown release date" }
        }

    /// I feel like this should disappear, eventually, and instead put this info into the TMDbRating struct in the tmdbRating var
    var tmdbVoteAverage: Double = -1
    var tmdbVoteCount: Int = -1
  
    var tmdbRating = TMDbRating()
    var imdbRating = IMDbRating()
    var rottenTomatoesRating = RottenTomatoesRating()
    var metacriticRating = MetacriticRating()
    var cinemascoreRating = CinemaScoreRating()
    
    /// Ultimately I think it would be best to get rid of this dictionary approach.
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
        case id
        case title
        case description = "overview"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case tmdbVoteAverage = "vote_average"
        case tmdbVoteCount = "vote_count"
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
    
    /// This custom initializer is necessary for the sake of TMDb's nonstandard JSON. TMDb returns an empty string for titles with no release date, rather than null. This whole initializer is for that.
    /// Essentially, it decodes the date as a string first, checks if it's empty, and then assigns releaseDate nil (if the string was empty) or the date (if it wasn't)
    /// AFAIK, this init makes a static example not work, because Movie *has* to initialize from decoded JSON.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.description = try container.decode(String.self, forKey: .description)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.tmdbVoteAverage = try container.decode(Double.self, forKey: .tmdbVoteAverage)
        self.tmdbVoteCount = try container.decode(Int.self, forKey: .tmdbVoteCount)
        
        let tempStringDate = try container.decode(String.self, forKey: .releaseDate)
            if tempStringDate.isEmpty { self.releaseDate = nil }
            else { self.releaseDate = try container.decode(Date.self, forKey: .releaseDate) }
    }
    
//    static let example1 = Movie(posterPath: "https://www.themoviedb.org/t/p/w1280/d5NXSklXo0qyIYkgV94XAgMIckC.jpg",
//                                description: """
//                                            Feature adaptation of Frank Herbert's science fiction novel, about the son of a noble family entrusted with the protection of the most valuable asset and most vital element in the galaxy.
//                                            """,
//                                id: 123456789,
//                                title: "Dune",
//                                tmdbVoteAverage: 7.8,
//                                tmdbVoteCount: 8029,
//                                length: "156 mins",
//                                ratings: [.imdb: 8.5, .rottenTomatoes: 90, .letterboxd: 4.2, .tmdb: 78, .cinemascore: 8])
}


