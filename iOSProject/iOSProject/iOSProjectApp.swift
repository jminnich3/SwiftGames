//
//  iOSProjectApp.swift
//  iOSProject
//
//  Created by COMP401 on 11/18/24.
//

import SwiftUI

@main
struct iOSProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(showWeb: false, needsOnboarding: true)
                .environmentObject(LocationModel())
                .environmentObject(DeckViewModel())
                .environmentObject(GameViewModel())
        }
    }
}
