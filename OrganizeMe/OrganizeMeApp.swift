//
//  OrganizeMeApp.swift
//  OrganizeMe
//
//  Created by Vedant on
//101398199

import SwiftUI

@main
struct OrganizeMeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
