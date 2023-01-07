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
                    .padding([.bottom])
                    .navigationTitle("Recent")
                }
                .task {
                    if Date.now.timeIntervalSince(viewModel.recentMoviesAge) > 60 {
                        await viewModel.getRecentMovies()
                    }
                }
            }
            .refreshable(action: viewModel.getRecentMovies)
        }
        
    }
}

struct RecentMovieListView: View {
    var movie: Movie
    let topThreeRatingSources: [RatingSource] = [.tmdb, .imdb, .rottenTomatoes, .metacritic, .cinemascore]

    var body: some View {
        VStack {
            HStack {
                Text(movie.title)
                    .font(.title2)
                    .italic()
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding([.horizontal, .bottom])

            HStack(spacing: 0) {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")")) { image in
                    image.resizable()
                } placeholder: { ProgressView() }
                    .scaledToFit()
                    .frame(width: 100)
                    .padding(.leading)
                    .shadow(radius: 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .firstTextBaseline) {
                        ForEach(topThreeRatingSources.filter( { movie.ratings[$0] ?? -1 >= 0 } ), id: \.self) { ratingSource in
                            CondensedRatingView(movie: movie, ratingSource: ratingSource)
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            Divider()
                .padding(.top)
        }
        .frame(height: 225)
        .foregroundColor(.primary)
    }
}

struct RecentView_Previews: PreviewProvider {
    static var previews: some View {
        RecentView()
    }
}
