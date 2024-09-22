import Foundation

struct Habit: Identifiable, Codable {
    let id: UUID
    let name: String
    var lastCompletedDate: Date?

    init(id: UUID = UUID(), name: String,  lastCompletedDate: Date? = nil) {
        self.id = id
        self.name = name
        self.lastCompletedDate = lastCompletedDate
    }
}