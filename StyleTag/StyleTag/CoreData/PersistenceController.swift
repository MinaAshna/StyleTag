//
//  DataController.swift
//  StyleTag
//
//  Created by Mina Ashna on 13/07/2023.
//

import CoreData
import Foundation

class PersistenceController: ObservableObject {
    let container = NSPersistentContainer(name: "StyleTag")

    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
