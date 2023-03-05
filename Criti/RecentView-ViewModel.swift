//
//  RecentView-ViewModel.swift
//  Criti
//
//  Created by Mark Roosma on 2022-12-01.
//

import Foundation

extension RecentView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var recentMovies: [Movie] = []
        
        var recentMoviesAge = Date.distantPast
        
        @Sendable func getRecentMovies() async {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKeys.TMDB)&language=en-US&page=1") else { return }
            recentMovies = await TMDb.getMovies(from: url)
            var tempMovies = recentMovies
            recentMovies = await Movie.getRemainingMovieDetails(for: &tempMovies)
            recentMoviesAge = Date.now
        }

    }
    
}
