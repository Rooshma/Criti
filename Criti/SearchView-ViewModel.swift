//
//  SearchView-ViewModel.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-31.
//

import Foundation

extension SearchView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var results: [Movie] = []
        
        func getResults(for title: String) async {
            guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(APIKeys.TMDB)&language=en-US&query=\(title.replacingOccurrences(of: " ", with: "%20"))&page=1&include_adult=false") else { return }
            results = await TMDb.getMovies(from: url)
            var tempResults = results
            // I think this has been factored out reasonably enough, but don't think this works for the search view: movie details only get updated the once, so if someone taps too soon, things will never get filled in.
            results = await Movie.getRemainingMovieDetails(for: &tempResults)
        }
        
    }
    
}
