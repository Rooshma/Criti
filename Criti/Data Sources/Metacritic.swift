//
//  Metacritic.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-18.
//

import Foundation
import SwiftSoup

struct Metacritic {
    
    static func getRatingFor(_ movie: Movie) async -> Movie.MetacriticRating {
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
                let audienceRating = try Int(audienceSummary.select("span.metascore_w").text()) ?? -1
                let audienceRatingCount = try Int(audienceSummary.select("span.based_on").text().trimmingCharacters(in: .decimalDigits.inverted)) ?? -1
                
                return Movie.MetacriticRating(criticRating: criticRating, criticRatingCount: criticRatingCount, audienceRating: audienceRating, audienceRatingCount: audienceRatingCount)
            }
        }
        catch {
            print("Error getting Metacritic rating")
        }
        return Movie.MetacriticRating()
    }
    
//    static func fillColor(for rating: Int) -> Color {
//        switch rating {
//            case 70...100: return Color("MCGreen")
//            case 40..<70: return Color("MCYellow")
//            case 0..<40: return Color("MCRed")
//            default: return Color("MCGray")
//        }
//    }
    
}
