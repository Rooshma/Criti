//
//  SettingsView-ViewModel.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-18.
//

import Foundation

extension SettingsView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var settings = Settings()
        
        func addRatingSource(_ ratingSource: RatingSource) {
            settings.ratingSources.append(ratingSource)
        }
        
        func removeRatingSource(at offsets: IndexSet) -> Void {
//            settings.ratingSources.re
//            settings.ratingSources.remove(at: settings.ratingSources.firstIndex(of: ratingSource)!)
//            for offset in offsets {
//                settings.unusedRatingSources.append(settings.ratingSources[offset])
//            }
            settings.ratingSources.remove(atOffsets: offsets)
        }
        
        // Main problem is this doesn't seem to update until the app is relaunched. Then it works, but that's too slow.
        func moveRatingSource(from source: IndexSet, to destination: Int) {
            settings.ratingSources.move(fromOffsets: source, toOffset: destination)
            if let encoded = try? JSONEncoder().encode(settings.ratingSources) {
                UserDefaults.standard.set(encoded, forKey: "ratingSources")
                print(encoded.prettyPrintedJSONString)
            }
        }
        
    }
    
}
