//
//  ContentView.swift
//  ahta
//
//  Created by Lewis Gorman-Neale on 08/06/2024.
//

import SwiftUI

struct ContentView: View {
    let tasks = ["Task 1", "Task 2", "Task 3"]

    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack {
                Text("ahta")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Text("another habit tracking app")
                ZStack {
                   List {
                        ForEach(tasks, id: \.self) { task in
                            Text(task)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
