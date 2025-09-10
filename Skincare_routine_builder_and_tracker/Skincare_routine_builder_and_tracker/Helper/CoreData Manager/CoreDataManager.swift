//
//  CoreDataManager.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import CoreData
import Foundation

// MARK: - CoreDataManager (Singleton)
final class CoreDataManager {
    static let shared = CoreDataManager()

    // Persistent container
    let persistentContainer: NSPersistentContainer

    // Context
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "SkincareDataModel") // Your .xcdatamodeld filename
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved Core Data error: \(error)")
            }
        }
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    // MARK: - Save
    func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
            print("✅ Context saved")
        } catch {
            print("❌ Failed to save context: \(error), \(error)")
        }
    }
}
