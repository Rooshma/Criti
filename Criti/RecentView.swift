//
//  RecentView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-11-30.
//

import SwiftUI

struct RecentView: View {

    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(viewModel.recentMovies) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            RecentMovieListView(movie: movie)
                        }
                    }
                    .padding([.horizontal, .bottom])
                    .navigationTitle("Latest")
                }
                .task {
                    await viewModel.getRecentMovies()
                }
            }
            .background(Color(red: 248 / 255, green: 244 / 255, blue: 214 / 255))
        }
        
    }
}

struct RecentMovieListView: View {
    var movie: Movie // = Movie.example1
    let topThreeRatingSources: [RatingSource] = [.tmdb, .imdb, .rottenTomatoes]

    var body: some View {
        VStack {
            HStack {
                Text(movie.title)
                    .font(.title2)
                Spacer()
                Image(systemName: "chevron.right")
            }
                .padding(.bottom)
            HStack {
                ForEach(topThreeRatingSources, id: \.self) { ratingSource in
                    CondensedRatingView(movie: movie, ratingSource: ratingSource)
                }
            }
            Divider()
                .padding(.top)
        }
        // This is here to override the navigationlinks making everything blue. Obvi pick more appropriate colours later
        .foregroundColor(.primary)
    }
}

struct RecentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentView()
    }
}
