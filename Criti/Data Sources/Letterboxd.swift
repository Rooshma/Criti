//
//  File.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-10.
//

import Foundation
import SwiftSoup

struct Letterboxd {
    
    struct Rating: Codable {
        var averageRating: Double = -1
        var histogram: [Int] = []
    }
    
    static func getRatings(for movie: inout Movie) async {
        let urlTitle = movie.title.lowercased().removeCharacters(from: .punctuationCharacters).replacingOccurrences(of: " ", with: "-")
        do {
            if let url = URL(string: "https://letterboxd.com/csi/film/\(urlTitle)/rating-histogram/") {
                let (data, _) = try await URLSession.shared.data(from: url)
                let html = String(data: data, encoding: .utf8) ?? ""
                let doc: Document = try SwiftSoup.parse(html)
                let averageRating = try Double(doc.select("span.average-rating").text()) ?? -1
                
                // It's possible this could be achieved more compactly by using a map transform on the array of elements. But I'm tired.
                var histogram: [Int] = []
                let ratingSpread = try doc.select("li.rating-histogram-bar")
                for rating in ratingSpread {
                    try histogram.append(Int(rating.text().components(separatedBy: " ")[0].removeCharacters(from: .decimalDigits.inverted)) ?? -1)
                }
                movie.letterboxdRating = Rating(averageRating: averageRating, histogram: histogram)
            }
        } catch {
            print("Error getting Letterboxd rating")
        }
        return //Rating()
    }
    
    static func pageURL(for movie: Movie) -> URL? {
        let urlTitle = movie.title.lowercased().removeCharacters(from: .punctuationCharacters).replacingOccurrences(of: " ", with: "-")
        return URL(string: "https://letterboxd.com/film/\(urlTitle)/")
    }
    
}
