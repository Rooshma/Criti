//
//  OMDbJSON.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-11.
//

import Foundation

struct OMDbIDResponse: Codable {
    var length: String
    var genre: String
    var director: String
    var ratings: [[String: String]]
    var imdbVotes: String
    var boxOffice: String

    enum CodingKeys: String, CodingKey {
        case length = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case ratings = "Ratings"
        case imdbVotes
        case boxOffice = "BoxOffice"
    }
}

// {"Title":"Dune","Year":"2021","Rated":"PG-13","Released":"22 Oct 2021","Runtime":"155 min","Genre":"Action, Adventure, Drama","Director":"Denis Villeneuve","Writer":"Jon Spaihts, Denis Villeneuve, Eric Roth","Actors":"Timothée Chalamet, Rebecca Ferguson, Zendaya","Plot":"A noble family becomes embroiled in a war for control over the galaxy's most valuable asset while its heir becomes troubled by visions of a dark future.","Language":"English, Mandarin","Country":"Canada, United States","Awards":"Won 6 Oscars. 168 wins & 281 nominations total","Poster":"https://m.media-amazon.com/images/M/MV5BN2FjNmEyNWMtYzM0ZS00NjIyLTg5YzYtYThlMGVjNzE1OGViXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"8.0/10"},{"Source":"Rotten Tomatoes","Value":"83%"},{"Source":"Metacritic","Value":"74/100"}],"Metascore":"74","imdbRating":"8.0","imdbVotes":"625,484","imdbID":"tt1160419","Type":"movie","DVD":"22 Oct 2021","BoxOffice":"$108,327,830","Production":"N/A","Website":"N/A","Response":"True"}
