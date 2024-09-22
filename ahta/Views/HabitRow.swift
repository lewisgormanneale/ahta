import SwiftUI

struct HabitRow: View {
    let habit: Habit
    let currentTime: Date
    let onComplete: () -> Void

    var body: some View {
        HStack {
            Text(habit.name)
                .font(.system(size: 24, weight: .bold, design: .serif))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            Spacer()
            Text(friendlyTimeString)
                .font(.system(size: 18, weight: .semibold, design: .serif))
                .minimumScaleFactor(0.5)
                .lineLimit(1)
            Button(action: onComplete) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.white)
                    .background(Color.black)
                    .clipShape(Circle())
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(Color.green.opacity(0.2))
    }

    var friendlyTimeString: String {
        guard let lastCompletedDate = habit.lastCompletedDate else {
            return "Never"
        }

        let interval = currentTime.timeIntervalSince(lastCompletedDate)
        let seconds = Int(interval)
        let minutes = seconds / 60
        let hours = minutes / 60
        let days = hours / 24

        if days > 0 {
            let remainingHours = hours % 24
            if remainingHours > 0 {
                return "\(days)d \(remainingHours)h"
            } else {
                return "\(days)d"
            }
        } else if hours > 0 {
            let remainingMinutes = minutes % 60
            if remainingMinutes > 0 {
                return "\(hours)h \(remainingMinutes)m"
            } else {
                return "\(hours)h"
            }
        } else if minutes > 0 {
            return "\(minutes)m"
        } else {
            return "\(seconds)s"
        }
    }
}   

struct HabitRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HabitRow(habit: Habit(name: "New Habit", lastCompletedDate: nil), currentTime: Date(), onComplete: {})
            HabitRow(habit: Habit(name: "30 Seconds Ago", lastCompletedDate: Date().addingTimeInterval(-30)), currentTime: Date(), onComplete: {})
            HabitRow(habit: Habit(name: "45 Minutes Ago", lastCompletedDate: Date().addingTimeInterval(-45*60)), currentTime: Date(), onComplete: {})
            HabitRow(habit: Habit(name: "3 Hours, 20 Minutes Ago", lastCompletedDate: Date().addingTimeInterval(-3*60*60 - 20*60)), currentTime: Date(), onComplete: {})
            HabitRow(habit: Habit(name: "2 Days, 5 Hours Ago", lastCompletedDate: Date().addingTimeInterval(-2*24*60*60 - 5*60*60)), currentTime: Date(), onComplete: {})
        }
        .previewLayout(.sizeThatFits)
    }
}