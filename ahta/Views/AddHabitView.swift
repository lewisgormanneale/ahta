import SwiftUI

struct AddHabitView: View {
    @Binding var isPresented: Bool
    let onSave: (String) -> Void
    @State private var habitName = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Habit Name", text: $habitName)
            }
            .navigationTitle("Add New Habit")
            .navigationBarItems(
                leading: Button("Cancel") { isPresented = false },
                trailing: Button("Save") {
                    if !habitName.isEmpty {
                        onSave(habitName)
                        isPresented = false
                    }
                }
            )
        }
    }
}

#Preview {
    AddHabitView(isPresented: .constant(true), onSave: { _ in })
}
