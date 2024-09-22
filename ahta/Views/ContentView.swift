import SwiftUI

struct ContentView: View {
    @State private var habits: [Habit] = []
    @State private var currentTime = Date()
    @State private var isAddingHabit = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            VStack {
                Text("ahta")
                    .font(.system(size: 48, weight: .heavy, design: .serif))
                    .padding()
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(habits) { habit in
                            HabitRow(habit: habit, currentTime: currentTime, onComplete: {
                                completeHabit(habit)
                            })
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
            
            VStack {
                Spacer()
                Button(action: {
                    isAddingHabit = true
                }) {
                    HStack {
                        Text("Add Habit")
                            .font(.system(size: 24, weight: .bold, design: .serif))
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(15)
                    .shadow(radius: 5)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 10)
            }
        }
        .sheet(isPresented: $isAddingHabit) {
            AddHabitView(isPresented: $isAddingHabit, onSave: addHabit)
        }
    }

    func addHabit(_ name: String) {
        let newHabit = Habit(name: name)
        habits.append(newHabit)
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
