//
//  SettingsView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-11-30.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = ViewModel()
    @State var editMode = EditMode.inactive
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Included rating sources")) {
                    ForEach(viewModel.ratingSources, id: \.self) { ratingSource in
                        Text(ratingSource.rawValue)
                    }
                    .onDelete { _ in
                        
                    }
                    .onMove { _, _ in
                        
                    }
                }
                Section(header: Text("Excluded rating sources")) {
                    ForEach(viewModel.unusedRatingSources, id: \.self) { ratingSource in
                        Text(ratingSource.rawValue)
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .navigationTitle("Settings")
            .navigationBarItems(leading: EditButton())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
