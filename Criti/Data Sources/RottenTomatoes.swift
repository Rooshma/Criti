//
//  RottenTomatoes.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-14.
//

import Foundation
import SwiftSoup

struct RottenTomatoes {
    
    struct Rating: Codable {
        var criticRating: Int = -1
        var criticRatingCount: Int = -1
        var audienceRating: Int = -1
        var audienceRatingCount: Int = -1
        var criticConsensus: String = ""
        var audienceConsensus: String = ""
        var certifiedFresh = false
    }
    
    static func getRatings(for movie: inout Movie) async {
        let urlTitle = movie.title.lowercased().removeCharacters(from: .punctuationCharacters).replacingOccurrences(of: " ", with: "_")
        do {
            if let url = URL(string: "https://www.rottentomatoes.com/m/\(urlTitle)") {
                let (data, _) = try await URLSession.shared.data(from: url)
                let html = String(data: data, encoding: .utf8) ?? ""
                let doc: Document = try SwiftSoup.parse(html)
                
                // Zoom in on scoreboard section of the document, get critic and audience ratings, certified fresh status
                let scoreBoard = try doc.getElementsByTag("score-board")
                let criticRating = try Int(scoreBoard.attr("tomatometerscore")) ?? -1
                let criticRatingCount = try Int(scoreBoard.select("a").first()?.text().removeCharacters(from: .decimalDigits.inverted) ?? "") ?? -1
                let audienceRating = try Int(scoreBoard.attr("audiencescore")) ?? -1
                let audienceRatingCount = try Int(scoreBoard.select("a").last()?.text().removeCharacters(from: .decimalDigits.inverted) ?? "") ?? -1
//                let certifiedFresh = try scoreBoard.attr("tomatometerstate") == "certified-fresh"
                
                // Zoom in on what to know section of the document, get critic and audience consensus text
                let whatToKnow = try doc.select("p.what-to-know__section-body")
                let criticConsensus = try whatToKnow.select("span").first()?.text() ?? ""
                let audienceConsensus = try whatToKnow.select("span").last()?.text() ?? ""
                
                movie.rottenTomatoesRating = Rating(criticRating: criticRating, criticRatingCount: criticRatingCount,
                                                  audienceRating: audienceRating, audienceRatingCount: audienceRatingCount,
                                                  criticConsensus: criticConsensus, audienceConsensus: audienceConsensus)
            }
        } catch {
            print("Error getting Rotten Tomatoes rating")
        }
        return
    }
    
    enum RatingType {
        case critic, audience
    }
    
    static func pageURL(for movie: Movie) -> URL? {
        let urlTitle = movie.title.lowercased().removeCharacters(from: .punctuationCharacters).replacingOccurrences(of: " ", with: "_")
        return URL(string: "https://www.rottentomatoes.com/m/\(urlTitle)")
    }
    
}
