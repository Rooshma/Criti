//
//  TabBarView.swift
//  Criti
//
//  Created by Mark Roosma on 2022-11-30.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView
        HStack {
            VStack {
                Image(systemName: "circle")
                    .font(.largeTitle)
                Text("Option 1")
                    .font(.caption)
                    .padding(.bottom)
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
