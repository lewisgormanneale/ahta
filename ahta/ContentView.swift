//
//  ContentView.swift
//  ahta
//
//  Created by Lewis Gorman-Neale on 08/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var habits: [Habit] = []
    @State private var newHabitName: String = ""

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add New Habit")) {
                    HStack {
                        TextField("New habit name", text: $newHabitName)
                        Button(action: addHabit) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }

                Section(header: Text("Your Habits")) {
                    ForEach(habits) { habit in
                        HStack {
                            Text(habit.name)
                            Spacer()
                            Button(action: { toggleHabit(habit) }) {
                                Image(systemName: isHabitCompletedToday(habit) ? "checkmark.circle.fill" : "circle")
                            }
                        }
                    }
                    .onDelete(perform: deleteHabits)
                }
            }
            .navigationTitle("Habit Tracker")
            .onAppear(perform: loadHabits)
        }
    }

    func addHabit() {
        guard !newHabitName.isEmpty else { return }
        let habit = Habit(name: newHabitName, completedDates: [])
        habits.append(habit)
        newHabitName = ""
        saveHabits()
    }

    func toggleHabit(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            let today = Calendar.current.startOfDay(for: Date())
            if let completedIndex = habits[index].completedDates.firstIndex(of: today) {
                habits[index].completedDates.remove(at: completedIndex)
            } else {
                habits[index].completedDates.append(today)
            }
            saveHabits()
        }
    }

    func deleteHabits(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        saveHabits()
    }

    func isHabitCompletedToday(_ habit: Habit) -> Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return habit.completedDates.contains(today)
    }

    func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "SavedHabits")
        }
    }

    func loadHabits() {
        if let savedHabits = UserDefaults.standard.data(forKey: "SavedHabits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habits = decodedHabits
            }
        }
    }
}

#Preview {
    ContentView()
}
