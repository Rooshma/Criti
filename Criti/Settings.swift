//
//  Settings.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-16.
//

import Foundation

@MainActor class Settings: ObservableObject {
    @Published var ratingSources: [RatingSource]
    var unusedRatingSources: [RatingSource] {
        return [.tmdb, .imdb, .letterboxd, .rottenTomatoes, .metacritic, .cinemascore].filter( { !ratingSources.contains($0) } )
    }
    
    init() {
        if let data = UserDefaults.standard.object(forKey: "ratingSources") as? Data {
            self.ratingSources = try! JSONDecoder().decode([RatingSource].self, from: data)
//        }
//        if let ratingSources = UserDefaults.standard.object(forKey: "ratingSources") {
//            self.ratingSources = ratingSources as! [RatingSource]
        } else {
            self.ratingSources = [.tmdb, .imdb, .letterboxd, .rottenTomatoes, .metacritic, .cinemascore]
        }
    }
}


//if let data = UserDefaults.standard.object(forKey: UserDefaultsKeys.jobCategory.rawValue) as? Data,
//   let category = try? JSONDecoder().decode(JobCategory.self, from: data) {
//     print(category.name)
//}
