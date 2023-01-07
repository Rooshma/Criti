//
//  ContentView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-04-06.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            RecentView()
                .tabItem {
                    Label("Recent", systemImage: "calendar")
                }
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
