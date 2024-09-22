import Foundation

struct Habit: Identifiable, Codable {
    let id = UUID()
    var name: String
    var completedDates: [Date]
}
