//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/14/25.
//

import SwiftUI

@main
struct FinalProjectApp: App {
    @StateObject private var profileVM = ProfileViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView(profileVM: profileVM)
        }
    }
}
