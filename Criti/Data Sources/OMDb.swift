//
//  OMDbJSON.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-11.
//

import Foundation

struct OMDb: Codable {
    
    struct SearchResponse: Codable {
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
    
    static func getOMDbData(for movie: inout Movie) async {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(APIKeys.OMDb)&i=\(movie.imdbID)") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonResponse = try JSONDecoder().decode(OMDb.SearchResponse.self, from: data)
            
            movie.length = jsonResponse.length
            movie.genres = jsonResponse.genre.components(separatedBy: ", ")
            
            for rating in jsonResponse.ratings {
                switch rating["Source"] {
                    case "Rotten Tomatoes":
                        let trimmedRating = rating["Value"]?.dropLast(1)
                        movie.ratings[.rottenTomatoes] = Double(trimmedRating ?? "0")
                    case "Internet Movie Database":
                        let trimmedRating = rating["Value"]?.dropLast(3)
                        movie.ratings[.imdb] = Double(trimmedRating ?? "0")
                        if let imdbVoteCount = Int(jsonResponse.imdbVotes.filter( { $0 != "," } )) {
                        movie.ratingCounts[.imdb] = imdbVoteCount
                        }
                    case "Metacritic":
                        let trimmedRating = rating["Value"]?.dropLast(4)
                        movie.ratings[.metacritic] = Double(trimmedRating ?? "0")
                    default:
                        print("No ratings")
                }
            }
        } catch {
            print("Error getting OMDb data")
            print(error)
        }
    }
    
}

/// Example search response below.
// {"Title":"Dune","Year":"2021","Rated":"PG-13","Released":"22 Oct 2021","Runtime":"155 min","Genre":"Action, Adventure, Drama","Director":"Denis Villeneuve","Writer":"Jon Spaihts, Denis Villeneuve, Eric Roth","Actors":"Timothée Chalamet, Rebecca Ferguson, Zendaya","Plot":"A noble family becomes embroiled in a war for control over the galaxy's most valuable asset while its heir becomes troubled by visions of a dark future.","Language":"English, Mandarin","Country":"Canada, United States","Awards":"Won 6 Oscars. 168 wins & 281 nominations total","Poster":"https://m.media-amazon.com/images/M/MV5BN2FjNmEyNWMtYzM0ZS00NjIyLTg5YzYtYThlMGVjNzE1OGViXkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_SX300.jpg","Ratings":[{"Source":"Internet Movie Database","Value":"8.0/10"},{"Source":"Rotten Tomatoes","Value":"83%"},{"Source":"Metacritic","Value":"74/100"}],"Metascore":"74","imdbRating":"8.0","imdbVotes":"625,484","imdbID":"tt1160419","Type":"movie","DVD":"22 Oct 2021","BoxOffice":"$108,327,830","Production":"N/A","Website":"N/A","Response":"True"}
