//
//  RatingSources.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-11.
//

import Foundation

enum RatingSource: String, Codable {
    case imdb = "IMDb"
    case rottenTomatoes = "Rotten Tomatoes"
    case letterboxd = "Letterboxd"
    case tmdb = "TMDb"
    case metacritic = "Metacritic"
    case cinemascore = "Cinemascore"
}
