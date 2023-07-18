//
//  StyleTagApp.swift
//  StyleTag
//
//  Created by Mina Ashna on 11/07/2023.
//

import SwiftUI

@main
struct StyleTagApp: App {
    @StateObject private var persistenceController = PersistenceController()
    
    var body: some Scene {
        WindowGroup {
            OutfitsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

