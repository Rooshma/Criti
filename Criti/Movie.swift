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

    // AFAIK this is only used during decode, and is then useless. If they could be removed for the decode process as well that would be ideal.
    var tmdbVoteAverage: Double = -1
    var tmdbVoteCount: Int = -1
  
    var tmdbRating = TMDb.Rating()
    var imdbRating = IMDb.Rating()
    var rottenTomatoesRating = RottenTomatoes.Rating()
    var metacriticRating = Metacritic.Rating()
    var cinemascoreRating = ""
    var letterboxdRating = Letterboxd.Rating()
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description = "overview"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case tmdbVoteAverage = "vote_average"
        case tmdbVoteCount = "vote_count"
    }
    
    // This custom initializer is necessary for the sake of TMDb's nonstandard JSON for null dates (it returns an empty string, not null).
    // This is also used to get JSON values for "vote_average" and "vote_count" into a TMDbRating struct.

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        self.description = try container.decode(String.self, forKey: .description)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        
        self.tmdbRating = TMDb.Rating(audienceRating: try container.decode(Double.self, forKey: .tmdbVoteAverage) * 10,
                                     audienceRatingCount: try container.decode(Int.self, forKey: .tmdbVoteCount))
        
        
        let tempStringDate = try container.decode(String.self, forKey: .releaseDate)
            if tempStringDate.isEmpty { self.releaseDate = nil }
            else { self.releaseDate = try container.decode(Date.self, forKey: .releaseDate) }
    }
    
    static func getRemainingMovieDetails(for movies: inout [Movie]) async -> [Movie] {
        // Change back to recentmovies.indices. Right now it's truncated to limit the number of calls.
        for i in 0 ..< 1 {
            await TMDb.getIMDbID(for: &movies[i])
            await OMDb.getOMDbData(for: &movies[i])
            await Cinemascore.getRatings(for: &movies[i])
            await Letterboxd.getRatings(for: &movies[i])
            await RottenTomatoes.getRatings(for: &movies[i])
            await Metacritic.getRatingFor(&movies[i])
            await IMDb.getRating(for: &movies[i])
        }
        return movies
    }
    
}


