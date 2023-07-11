//
//  StyleTagApp.swift
//  StyleTag
//
//  Created by Mina Ashna on 11/07/2023.
//

import SwiftUI

@main
struct StyleTagApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
