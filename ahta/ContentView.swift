//
//  ContentView.swift
//  ahta
//
//  Created by Lewis Gorman-Neale on 08/06/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.green)
                .ignoresSafeArea()
            VStack {
                Text("atah")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    ContentView()
}
