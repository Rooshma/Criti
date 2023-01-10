//
//  PosterView.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-08.
//

import SwiftUI

struct PosterView: View {
    let movie: Movie
    let width: CGFloat
    
    /// This requires width but not height to be specified. Might be nice if either (or both) could be specified. That also might not be necessary, though. Currently it works alright. Think on this.
    
    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")")) { image in
            image.resizable()
        } placeholder: { ProgressView() }
            .scaledToFit()
            .frame(width: width)
    }
}
