//
//  Settings.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-16.
//

import Foundation

@MainActor class Settings: ObservableObject {
    @Published var ratingSources: [RatingSource]
//    var unusedRatingSources: [RatingSource] {
//        return [.tmdb, .imdb, .letterboxd, .rottenTomatoes, .metacritic, .cinemascore].filter( { !ratingSources.contains($0) } )
//    }
    @Published var unusedRatingSources: [RatingSource]
    
    init() {
        if let data = UserDefaults.standard.object(forKey: "ratingSources") as? Data {
            self.ratingSources = try! JSONDecoder().decode([RatingSource].self, from: data)
        } else {
            self.ratingSources = [.tmdb, .imdb, .letterboxd, .rottenTomatoes, .metacritic, .cinemascore]
        }
        if let data = UserDefaults.standard.object(forKey: "unusedRatingSources") as? Data {
            self.unusedRatingSources = try! JSONDecoder().decode([RatingSource].self, from: data)
        } else {
            self.unusedRatingSources = []
        }
    }
}
