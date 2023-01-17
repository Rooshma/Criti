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

    /// AFAIK this is only used during decode, and is then useless. If they could be removed for the decode process as well that would be ideal.
    var tmdbVoteAverage: Double = -1
    var tmdbVoteCount: Int = -1
  
    var tmdbRating = TMDbRating()
    var imdbRating = IMDbRating()
    var rottenTomatoesRating = RottenTomatoesRating()
    var metacriticRating = MetacriticRating()
    var cinemascoreRating = CinemaScoreRating()
    var letterboxdRating = LetterboxdRating()
    
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
        var certifiedFresh = false
    }
    
    struct LetterboxdRating: Codable {
        var averageRating: Double = -1
        var histogram: [Int] = []
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
    
    /// This custom initializer is necessary for the sake of TMDb's nonstandard JSON for null dates (it returns an empty string, not null).
    /// This is also used to get JSON values for "vote_average" and "vote_count" into a TMDbRating struct.

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.description = try container.decode(String.self, forKey: .description)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        
        self.tmdbRating = TMDbRating(audienceRating: try container.decode(Double.self, forKey: .tmdbVoteAverage) * 10,
                                     audienceRatingCount: try container.decode(Int.self, forKey: .tmdbVoteCount))
        
        
        let tempStringDate = try container.decode(String.self, forKey: .releaseDate)
            if tempStringDate.isEmpty { self.releaseDate = nil }
            else { self.releaseDate = try container.decode(Date.self, forKey: .releaseDate) }
    }
}


