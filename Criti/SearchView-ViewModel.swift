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
            await getRemainingMovieDetails()
        }
        
        func getRemainingMovieDetails() async {
            // Change back to recentmovies.indices. Right now it's truncated to limit the number of calls.
            // **** THIS IS BUSTED! WORKS FINE FOR RECENT VIEW, BUT NOT FOR SEARCH. *****
            for i in results[0...2].indices {
                insertTMDbRatings(i)
                await getIMDbID(i)
                await getOMDbData(i)
                await getCinemascoreData(i)
            }
        }
        
        func insertTMDbRatings(_ i: Int) {
            results[i].ratings[.tmdb] = results[i].tmdbVoteAverage * 10
        }
        
        func getIMDbID(_ i: Int) async {
            let movie = results[i]
            let imdbID = await TMDb.getIMDbID(for: movie)
            results[i].imdbID = imdbID
        }
        
        func getOMDbData(_ i: Int) async {
            var movie = results[i]
            await OMDb.getOMDbData(for: &movie)
            results[i] = movie
        }
        
        func getCinemascoreData(_ i: Int) async {
            let movie = results[i]
            results[i].ratings[.cinemascore] = await Cinemascore.getRatings(for: movie)
        }
        
    }
    
}
