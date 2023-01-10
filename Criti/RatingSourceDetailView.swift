//
//  SwiftUIView.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-09.
//

import SwiftUI

struct RatingSourceDetailView: View {
    let ratingSource: RatingSource
    
    var body: some View {
        switch ratingSource {
            case .rottenTomatoes: RottenTomatoesInfoView()
            case .imdb: IMDbInfoView()
            default: Text("N/A")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RatingSourceDetailView(ratingSource: .rottenTomatoes)
    }
}
