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
            HStack(spacing: 0) {
                PosterView(movie: movie)
                    .frame(height: 190)
                    .padding(.leading)
                    .shadow(radius: 10)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.fixed(90)), GridItem(.fixed(90))]) {
                        ForEach(settings.ratingSources, id: \.self) { ratingSource in
                            CondensedRatingView(movie: movie, ratingSource: ratingSource)
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            
            Divider()
                .overlay(.secondary)
                .padding(.vertical)

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
