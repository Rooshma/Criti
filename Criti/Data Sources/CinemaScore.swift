//
//  File.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-24.
//

import Foundation

struct Cinemascore {
    
    struct SearchResponse: Codable {
        var title = ""
        var grade = "N/A"
        var year = ""
        
        enum CodingKeys: String, CodingKey {
            // case title = "TITLE"
            case grade = "GRADE"
            // case year = "YEAR"
        }
        
        
        // TODO: MAKE THIS UNNECESSARY. THE NEW CINEMASCORERATING STRUCT SHOULD BE A START FOR DOING THAT.
        static let lettersToNumbers: [String: Double] = ["A+": 10,
                                                         "A": 9,
                                                         "A-": 8,
                                                         "B+": 7,
                                                         "B": 6,
                                                         "B-": 5,
                                                         "C+": 4,
                                                         "C": 3,
                                                         "C-": 2,
                                                         "F": 1,
                                                         "N/A": -1]
        
        static let numbersToLetters: [Double: String] = [10: "A+",
                                                         9: "A",
                                                         8: "A-",
                                                         7: "B+",
                                                         6: "B",
                                                         5: "B-",
                                                         4: "C+",
                                                         3: "C",
                                                         2: "C-",
                                                         1: "F",
                                                         -1: "N/A"]
        
    }
    
    static func getScore(for movie: Movie) async -> Double {
        let urlAppropriateTitle = Data(movie.title.utf8).base64EncodedString()
        guard let url = URL(string: "https://api.cinemascore.com/guest/search/title/\(urlAppropriateTitle)") else { return -1 }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonResponse = try JSONDecoder().decode([Cinemascore.SearchResponse].self, from: data)
            return Cinemascore.SearchResponse.lettersToNumbers[jsonResponse[0].grade] ?? -1
        } catch {
            print("Error getting Cinemascore data")
            print(error)
            return -1
        }
    }
    
}
