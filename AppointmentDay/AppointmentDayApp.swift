//
//  AppointmentDayApp.swift
//  AppointmentDay
//
//  Created by David on 10/7/22.
//

import SwiftUI

@main
struct AppointmentDayApp: App {
    var body: some Scene {
        WindowGroup {
            
            let viewContext = DataManager.shared.persistentStoreContainer.viewContext
            
            ContentView()
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
