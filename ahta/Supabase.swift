//
//  Supabase.swift
//  ahta
//
//  Created by Lewis Gorman-Neale on 14/08/2024.
//

import Supabase
import Foundation

struct Habit: Decodable, Identifiable {
    let id: UUID
    let name: String
    var lastDone: Date
}

class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    private let client = SupabaseClient(
      supabaseURL: URL(string: "https://rwrlxeoppxekurpvwmud.supabase.co")!,
      supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ3cmx4ZW9wcHhla3VycHZ3bXVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM2NjY5MzcsImV4cCI6MjAzOTI0MjkzN30.TWmI83ptG9UrYkjCGDbD958nN3RQH-S6a5t1PZrw3No"
    )
    
    func fetchHabits() {
        client.database.from("habits").select().execute { result in
            switch result {
            case .success(let response):
                if let data = response.data as? [[String: Any]] {
                    DispatchQueue.main.async {
                        self.habits = data.compactMap { dict in
                            guard let idString = dict["id"] as? String,
                                  let id = UUID(uuidString: idString),
                                  let name = dict["name"] as? String,
                                  let lastDoneString = dict["last_done"] as? String,
                                  let lastDone = ISO8601DateFormatter().date(from: lastDoneString) else {
                                return nil
                            }
                            return Habit(id: id, name: name, lastDone: lastDone)
                        }
                    }
                }
            case .failure(let error):
                print("Error fetching habits: \(error.localizedDescription)")
            }
        }
    }
}
