import SwiftUI

struct ContentView: View {
    @State private var habits: [Habit] = []
    @State private var currentTime = Date()
    @State private var newHabitName = ""
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("ahta")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(habits) { habit in
                        HabitRow(habit: habit, currentTime: currentTime, onComplete: { completeHabit(habit) })
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green.opacity(0.3))
        .onAppear(perform: loadHabits)
        .onReceive(timer) { _ in
            currentTime = Date()
        }
    }

    func addHabit() {
        guard !newHabitName.isEmpty else { return }
        let habit = Habit(name: newHabitName)
        habits.append(habit)
        newHabitName = ""
        saveHabits()
    }

    func deleteHabits(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        saveHabits()
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

    func completeHabit(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].lastCompletedDate = Date()
            saveHabits()
        }
    }
}

#Preview {
    ContentView()
}
