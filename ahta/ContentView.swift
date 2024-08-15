//
//  ContentView.swift
//  ahta
//
//  Created by Lewis Gorman-Neale on 08/06/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HabitViewModel()

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
                        ForEach(viewModel.habits) { habit in
                            HabitView(habit: habit)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchHabits()
            }
        }
    }
}

struct HabitView: View {
    let habit: Habit
    @State private var elapsedTime: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.name)
                .font(.headline)
            Text("Last done: \(elapsedTime)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onAppear {
            startTimer()
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let interval = Date().timeIntervalSince(habit.lastDone)
            let hours = Int(interval) / 3600
            let minutes = (Int(interval) % 3600) / 60
            let seconds = Int(interval) % 60
            elapsedTime = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
}

#Preview {
    ContentView()
}
