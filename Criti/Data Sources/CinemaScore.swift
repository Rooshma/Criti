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
    }
    
    static let exampleMovies: [String: [String]] = ["A+": ["Titanic (1997)", "The Polar Express (2004)", "The Blind Side (2009)"],
                                                    "A": ["Avatar (2009)", "Who Framed Roger Rabbit (1988)", "Coach Carter (2005)"],
                                                    "A-": ["The Abyss (1989)", "Contact (1997)", "A League of Their Own (1992)"],
                                                    "B+": ["Rocky Balboa (2006)", "A Christmas Carol (2009)", "Inception (2012)"],
                                                    "B": ["Cast Away (2000)", "Tenet (2020)", "Eternals (2021)"],
                                                    "B-": ["Blue Velvet (1986)", "Beowulf (2007)", "Major League 3: Back to the Minors (1998)"],
                                                    "C+": ["Starship Troopers (1997)", "Office Space (1999)", "Uncut Gems (2019)"],
                                                    "C": ["Boogie Nights (1997)", "The Thin Red Line (1998)", "The Wolf of Wall Street (2013)"],
                                                    "C-": ["Magnolia (1999)", "Drive (2011)", "The Witch (2016)"],
                                                    "D+": ["Punch-Drunk Love (2002)", "The New World (2006)", "Hereditary (2018)"],
                                                    "D": ["American Psycho (2000)", "The Life Aquatic With Steve Zissou (2004)", "The Happening (2008)"],
                                                    "D-": ["Eyes Wide Shut (1999)", "Vanilla Sky (2001)", "Gigli (2003)"],
                                                    "F": ["Solaris (2002)", "The Wicker Man (2006)", "mother! (2017)"]]
    
    static func getRatings(for movie: inout Movie) async {
        let urlAppropriateTitle = Data(movie.title.utf8).base64EncodedString()
        guard let url = URL(string: "https://webapp.cinemascore.com/guest/search/title/\(urlAppropriateTitle)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonResponse = try JSONDecoder().decode([Cinemascore.SearchResponse].self, from: data)
            movie.cinemascoreRating = jsonResponse[0].grade
        } catch {
            print("Error getting Cinemascore data for \(movie.title)")
            print(error)
            return
        }
    }
    
}
