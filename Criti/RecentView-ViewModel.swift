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
        
        func getRecentMovies() async {
//            print("Trying to get recent movies...")
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(APIKeys.TMDB)&language=en-US&page=1") else {
                print("URL Didn't work!")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let jsonResponse = try JSONDecoder().decode(TMDbNowPlayingResponse.self, from: data)
                recentMovies = jsonResponse.results
                await getRemainingMovieDetails()
//                print(recentMovies)
            } catch {
                print("error getting or decoding JSON")
                print(error)
            }
        }
        
        func getRemainingMovieDetails() async {
            // Change back to recentmovies.indices. Right now it's truncated to limit the number of calls.
            for i in recentMovies[0...2].indices {
                insertTMDbRatings(i)
                await getIMDbIDs(i)
                await getOMDbData(i)
            }
            print(recentMovies)
        }
        
        func insertTMDbRatings(_ i: Int) {
            recentMovies[i].ratings[.tmdb] = recentMovies[i].tmdbVoteAverage * 10
        }
        
        func getIMDbIDs(_ i: Int) async {
            let movie = recentMovies[i]
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)/external_ids?api_key=\(APIKeys.TMDB)") else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let jsonResponse = try JSONDecoder().decode(TMDbExternalIDsResponse.self, from: data)
                recentMovies[i].imdbID = jsonResponse.imdbID
            } catch {
                print("error getting imdb ids")
                print(error)
            }
        }
        
        func getOMDbData(_ i: Int) async {
            let movie = recentMovies[i]
            guard let url = URL(string: "https://www.omdbapi.com/?apikey=\(APIKeys.OMDb)&i=\(movie.imdbID)") else { return }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                if let prettyPrintedJSONString = data.prettyPrintedJSONString { print(prettyPrintedJSONString) }

                let jsonResponse = try JSONDecoder().decode(OMDbIDResponse.self, from: data)
                recentMovies[i].length = jsonResponse.length
                recentMovies[i].genres = jsonResponse.genre.components(separatedBy: ", ")
                for rating in jsonResponse.ratings {
                    switch rating["Source"] {
                        case "Rotten Tomatoes":
                            let trimmedRating = rating["Value"]?.dropLast(1)
                            recentMovies[i].ratings[.rottenTomatoes] = Double(trimmedRating ?? "0")
                        case "Internet Movie Database":
                            let trimmedRating = rating["Value"]?.dropLast(3)
                            recentMovies[i].ratings[.imdb] = Double(trimmedRating ?? "0")
                            if let imdbVoteCount = Int(jsonResponse.imdbVotes.filter( { $0 != "," } )) {
                                recentMovies[i].ratingCounts[.imdb] = imdbVoteCount
                            }
                        case "Metacritic":
                            let trimmedRating = rating["Value"]?.dropLast(4)
                            recentMovies[i].ratings[.metacritic] = Double(trimmedRating ?? "0")
                        default:
                            print("No ratings")
                    }
                }
            } catch {
                print("error getting OMDb data")
                print(error)
            }
        }
        
    }
    
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
