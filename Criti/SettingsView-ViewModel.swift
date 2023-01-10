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
        
        func addRatingSource(_ ratingSource: RatingSource) {
            /// CAREFUL! FORCE UNWRAPPING!
            unusedRatingSources.remove(at: unusedRatingSources.firstIndex(of: ratingSource)!)
            ratingSources.append(ratingSource)
        }
        
        func removeRatingSource(_ ratingSource: RatingSource) {  //at offsets: IndexSet) {
//            var sources: [RatingSource] = []
//            for index in offsets {
//                sources.append(ratingSources[index])
//            }
//            ratingSources.remove(atOffsets: offsets)
//            unusedRatingSources.append(contentsOf: sources)
            
            ratingSources.remove(at: ratingSources.firstIndex(of: ratingSource)!)
            unusedRatingSources.append(ratingSource)
        }
        
        func moveRatingSource(from source: IndexSet, to destination: Int) {
            ratingSources.move(fromOffsets: source, toOffset: destination)
        }
        
    }
    
}
