import SwiftUI

struct HabitRow: View {
    let habit: Habit
    let currentTime: Date
    let onComplete: () -> Void

    var body: some View {
        HStack {
            Text(habit.name)
                .font(.headline)
            Spacer()
            Text(timeString)
                .font(.subheadline)
            Button(action: onComplete) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.green.opacity(0.2))
    }

    var timeString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        let interval = currentTime.timeIntervalSince(habit.lastCompletedDate ?? Date.distantPast)
        return formatter.string(from: interval) ?? "00:00:00"
    }
}

// Preview provider for HabitRow
struct HabitRow_Previews: PreviewProvider {
    static var previews: some View {
        HabitRow(habit: Habit(name: "Sample Habit"), currentTime: Date(), onComplete: {})
            .previewLayout(.sizeThatFits)
    }
}
