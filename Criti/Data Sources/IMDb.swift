//
//  IMDb.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-21.
//

import Foundation
import SwiftSoup

struct IMDb {
    
    struct Rating: Codable {
        var averageRating: Double = -1
        var ratingCount: Int = -1
        var allUserRatings: [Double] = []
        var maleUserRatings: [Double] = []
        var femaleUserRatings: [Double] = []
    }
    
    static func getRating(for movie: inout Movie) async {
        do {
            if let url = URL(string: "https://www.imdb.com/title/\(movie.imdbID)/ratings") {
                let (data, _) = try await URLSession.shared.data(from: url)
                let html = String(data: data, encoding: .utf8) ?? ""
                let doc: Document = try SwiftSoup.parse(html)
                
                let summarySection = try doc.select("div.allText").select("table").select("div.bigCell").text().components(separatedBy: " ")
                
                guard summarySection.count >= 15 else {
                    print("Error getting IMDb rating for id \(movie.imdbID)")
                    print(summarySection)
                    return }
                
                let allUsers = summarySection[0...4].map( { Double($0) ?? -1 } )
                let maleUsers = summarySection[5...9].map( { Double($0) ?? -1 } )
                let femaleUsers = summarySection[10...14].map( { Double($0) ?? -1 } )
                                
                movie.imdbRating = Rating(averageRating: allUsers[0], ratingCount: -1, allUserRatings: allUsers, maleUserRatings: maleUsers, femaleUserRatings: femaleUsers)
            }
        }
        catch {
            print("Error getting IMDb rating")
        }
        return
    }
    
    static func pageURL(for movie: Movie) -> URL? { URL(string: "https://www.imdb.com/title/\(movie.imdbID)/ratings") }
    
}
