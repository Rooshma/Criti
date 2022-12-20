//
//  SettingsView-ViewModel.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-18.
//

import Foundation

extension SettingsView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var ratingSources: [RatingSource] = [.metacritic, .imdb, .rottenTomatoes, .tmdb, .letterboxd]
        @Published var unusedRatingSources: [RatingSource] = []
        
    }
    
}
