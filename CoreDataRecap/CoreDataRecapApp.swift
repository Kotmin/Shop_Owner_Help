//
//  CoreDataRecapApp.swift
//  CoreDataRecap
//
//  Created by Paweł Jan Tłusty on 06/03/2024.
//

import SwiftUI

@main
struct CoreDataRecapApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
