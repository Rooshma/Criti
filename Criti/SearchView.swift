//
//  SearchView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-11-30.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Search for a movie", text: $searchText)
                        .onSubmit {
                            Task {
                                await viewModel.getResults(for: searchText)
                            }
                    }
                }
                
                ForEach(viewModel.results) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w185\(movie.posterPath ?? "")")) { image in
                                image.resizable()
                            } placeholder: { ProgressView() }
                                .scaledToFit()
                                .frame(width: 50, height: 75)
                            /// This is, at best, half-finished, even if the search functionality gets fixed.
                            Text("\(movie.title) (\(movie.wrappedReleaseDate)))")
                                .task {
                                    await viewModel.getRemainingMovieDetails()
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
