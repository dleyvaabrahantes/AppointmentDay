//
//  File.swift
//  AppointmentDay
//
//  Created by David on 10/13/22.
//

import Foundation
import CoreData

class DataManager  {
    let persistentStoreContainer: NSPersistentContainer
    static let shared = DataManager()
    
    init() {
        persistentStoreContainer = NSPersistentContainer(name: "Model")
        persistentStoreContainer.loadPersistentStores { description, error in
            if let error = error{
                fatalError("Unable to load core data \(error)")
            }
            
        }
    }
}
