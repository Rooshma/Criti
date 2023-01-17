//
//  PosterView.swift
//  Criti
//
//  Created by Mark Roosma on 2023-01-08.
//

import SwiftUI

struct PosterView: View {
    let movie: Movie
    
    var body: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")")) { image in
            image.resizable()
        } placeholder: { ProgressView() }
            .scaledToFit()
    }
}
