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
        
        // I don't understand what @Sendable is/does. Investigate further.
        @Sendable func getRecentMovies() async {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKeys.TMDB)&language=en-US&page=1") else { return }
            recentMovies = await TMDb.getMovies(from: url)
            await getRemainingMovieDetails()
            recentMoviesAge = Date.now
        }
        
        func getRemainingMovieDetails() async {
            // Change back to recentmovies.indices. Right now it's truncated to limit the number of calls.
            // Could also probably just do let movie = recentMovies[i] at the beginning and just... make it all one function. Honestly simpler at that point.
            for i in recentMovies[0...2].indices {
                insertTMDbRatings(i)
                await getIMDbID(i)
                await getOMDbData(i)
                await getCinemascoreData(i)
                await getLetterboxdRating(i)
                await getRottenTomatoesRating(i)
                await getMetacriticRating(i)
            }
        }
        
        func insertTMDbRatings(_ i: Int) {
            recentMovies[i].ratings[.tmdb] = recentMovies[i].tmdbVoteAverage * 10
        }
        
        func getIMDbID(_ i: Int) async {
            let movie = recentMovies[i]
            let imdbID = await TMDb.getIMDbID(for: movie)
            recentMovies[i].imdbID = imdbID
        }
        
        func getOMDbData(_ i: Int) async {
            var movie = recentMovies[i]
            await OMDb.getOMDbData(for: &movie)
            recentMovies[i] = movie
        }
        
        func getCinemascoreData(_ i: Int) async {
            let movie = recentMovies[i]
            recentMovies[i].ratings[.cinemascore] = await Cinemascore.getRatings(for: movie)
        }
        
        func getLetterboxdRating(_ i: Int) async {
            let movie = recentMovies[i]
            recentMovies[i].letterboxdRating = await Letterboxd.getRatings(for: movie)
        }
        
        func getRottenTomatoesRating(_ i: Int) async {
            let movie = recentMovies[i]
            recentMovies[i].rottenTomatoesRating = await RottenTomatoes.getRatings(for: movie)
        }
        
        func getMetacriticRating(_ i: Int) async {
            let movie = recentMovies[i]
            recentMovies[i].metacriticRating = await Metacritic.getRatingFor(movie)
        }
        
    }
    
}
