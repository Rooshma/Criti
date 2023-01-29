//
//  Metacritic.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-18.
//

import Foundation
import SwiftSoup

struct Metacritic {
    
    struct Rating: Codable {
        var criticRating: Int = -1
        var criticRatingCount: Int = -1
        var audienceRating: Int = -1
        var audienceRatingCount: Int = -1
        var audienceRatingOutOfTen: Double { Double(audienceRating) / 10 }
    }
    
    static func getRatingFor(_ movie: Movie) async -> Rating {
        let urlTitle = movie.title.lowercased().removeCharacters(from: .punctuationCharacters).replacingOccurrences(of: " ", with: "-")
        do {
            if let url = URL(string: "https://www.metacritic.com/movie/\(urlTitle)") {
                let (data, _) = try await URLSession.shared.data(from: url)
                let html = String(data: data, encoding: .utf8) ?? ""
                let doc = try SwiftSoup.parse(html)
                
                let criticSummary = try doc.select("div.ms_wrapper")
                let criticRating = try Int(criticSummary.select("td.summary_right").text()) ?? -1
                let criticRatingCount = try Int(criticSummary.select("span.based_on").text().trimmingCharacters(in: .decimalDigits.inverted)) ?? -1
                
                let audienceSummary = try doc.select("div.us_wrapper")
                let audienceRatingDouble = try Double(audienceSummary.select("span.metascore_w").text()) ?? -1
                let audienceRatingInt = Int(audienceRatingDouble * 10)
                let audienceRatingCount = try Int(audienceSummary.select("span.based_on").text().trimmingCharacters(in: .decimalDigits.inverted)) ?? -1

                return Rating(criticRating: criticRating, criticRatingCount: criticRatingCount, audienceRating: audienceRatingInt, audienceRatingCount: audienceRatingCount)
            }
        }
        catch {
            print("Error getting Metacritic rating")
        }
        return Rating()
    }
    
    static func consensusPhrase(for rating: Int) -> String {
        switch rating {
            case 81...100: return "Universal acclaim"
            case 61...80: return "Generally favourable reviews"
            case 40...60: return "Mixed or average reviews"
            case 20..<40: return "Generally unfavourable reviews"
            case 0..<20: return "Overwhelming dislike"
            default: return "No score yet"
        }
    }
    
    static func fillColor(for rating: Int) -> String {
        switch rating {
            case 60...100: return "MCGreen"
            case 40..<60: return "MCYellow"
            case 0..<40: return "MCRed"
            default: return "MCGray"
        }
    }
    
    static func pageURL(for movie: Movie) -> URL? {
        let urlTitle = movie.title.lowercased().removeCharacters(from: .punctuationCharacters).replacingOccurrences(of: " ", with: "-")
        return URL(string: "https://www.metacritic.com/movie/\(urlTitle)")
    }
    
}
