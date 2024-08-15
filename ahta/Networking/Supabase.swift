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
    
    func fetchHabits() async -> [Habit]?  {
        do {
            let fetchedHabits: [Habit] = try await client.from("habits").select().execute().value
            return fetchedHabits
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
}
