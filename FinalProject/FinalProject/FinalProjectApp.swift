//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/14/25.
//

import SwiftData
import SwiftUI

@main
struct FinalProjectApp: App {
    @StateObject private var profileVM = ProfileViewModel()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WidgetModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            print("Successfully created ModelContainer")
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            print(error)
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView(profileVM: profileVM)
        }
        .modelContainer(sharedModelContainer)
    }
}
