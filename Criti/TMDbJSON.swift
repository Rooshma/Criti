//
//  TMDBJSON.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-04.
//

import Foundation

struct TMDbNowPlayingResponse: Codable {
    var results: [Movie]
}

struct TMDbExternalIDsResponse: Codable {
    var imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case imdbID = "imdb_id"
    }
}
