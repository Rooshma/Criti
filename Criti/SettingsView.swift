//
//  SettingsView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-11-30.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = ViewModel()
    @State private var editingSources = false
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Section(header: Text("Included rating sources")) {
                        ForEach(settings.ratingSources, id: \.self) { ratingSource in
                            HStack {
                                if editingSources {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
//                                        .onTapGesture {
//                                            withAnimation {
//                                                viewModel.removeRatingSource(ratingSource)
//                                            }
//                                        }
                                }
                                NavigationLink {
                                    RatingSourceDetailView(ratingSource: ratingSource)
                                } label: {
                                    Text(ratingSource.rawValue)
                                }
                            }
                        }
                        .onMove { origin, destination in
                            viewModel.moveRatingSource(from: origin, to: destination)
                        }
                        .onDelete(perform: viewModel.removeRatingSource)
                    }
                    Section(header: Text("Excluded rating sources")) {
                        ForEach(viewModel.settings.unusedRatingSources, id: \.self) { ratingSource in
                            HStack {
                                if editingSources {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.green)
                                        .onTapGesture {
                                            withAnimation {
                                                viewModel.addRatingSource(ratingSource)
                                            }
                                        }
                                }
                                Text(ratingSource.rawValue)
                            }
                        }
                    }
                }
                .navigationTitle("Settings")
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "plus.forwardslash.minus")
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                            .onTapGesture {
                                withAnimation {
                                    editingSources.toggle()
                                }
                            }
                    }
                    .padding()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
