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
                            if movie.posterPath != nil && !movie.posterPath.isEmpty {
                                PosterView(movie: movie, width: 50)
                            }
                            Text("\(movie.title) (\(movie.wrappedReleaseYear))")
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
