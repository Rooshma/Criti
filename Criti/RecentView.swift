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
                    .foregroundColor(Color("AccentColor"))
                }
                .task {
                    if Date.now.timeIntervalSince(viewModel.recentMoviesAge) > 600 {
                        await viewModel.getRecentMovies()
                    }
                }
            }
            .refreshable(action: viewModel.getRecentMovies)
        }
        
    }
}

struct RecentMovieListView: View {
    @EnvironmentObject var settings: Settings
    
    var movie: Movie

    var body: some View {
        VStack {
            HStack {
                Text(movie.title)
                    .font(.title2)
                    .italic()
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()

            HStack(spacing: 0) {
                PosterView(movie: movie)
                    .frame(height: 150)
                    .padding(.leading)
                    .shadow(radius: 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center) {
                        ForEach(settings.ratingSources, id: \.self) { ratingSource in
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
