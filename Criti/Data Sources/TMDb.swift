//
//  TMDBJSON.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-04.
//

import Foundation

struct TMDb: Codable {
    
    struct QueryResponse: Codable {
        var results: [Movie]
    }
    
    struct ExternalIDsResponse: Codable {
        var imdbID: String
        
        enum CodingKeys: String, CodingKey {
            case imdbID = "imdb_id"
        }
    }
    
    static func getMovies(from url: URL) async -> [Movie] {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = .localizedStringWithFormat("yyyy-MM-dd")
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let jsonResponse = try decoder.decode(TMDb.QueryResponse.self, from: data)
            return jsonResponse.results
        } catch {
            print("Error getting or decoding JSON")
            print(error)
        }
        return []
    }
    
    static func getIMDbID(for movie: Movie) async -> String {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/external_ids?api_key=\(APIKeys.TMDB)") else { return "" }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonResponse = try JSONDecoder().decode(TMDb.ExternalIDsResponse.self, from: data)
            return jsonResponse.imdbID
        } catch {
            print("error getting IMDb ids")
            print(error)
            return ""
        }
    }
    
}