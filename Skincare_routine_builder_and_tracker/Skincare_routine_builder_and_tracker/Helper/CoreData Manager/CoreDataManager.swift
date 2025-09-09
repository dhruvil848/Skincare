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
        return persistentContainer.viewContext
    }

    private init() {
        persistentContainer = NSPersistentContainer(name: "SkincareModel") // Your .xcdatamodeld filename
        persistentContainer.loadPersistentStores { storeDescription, error in
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
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    func getDailyRoutine(for date: Date) -> SCDay {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        
        // 1. Check if day already exists
        let request: NSFetchRequest<SCDay> = SCDay.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", startOfDay as NSDate)
        request.fetchLimit = 1
        
        if let existingDay = try? context.fetch(request).first {
            return existingDay
        }
        
        // 2. Day does not exist → create new
        return generateDailyRoutine(for: date)
    }

    // MARK: - Create Base Routines (After Onboarding)
    func createBaseRoutineIfNeeded() {
        let fetchRequest: NSFetchRequest<SCRoutineTemplate> = SCRoutineTemplate.fetchRequest()

        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                // Morning Routine
                let morning = SCRoutineTemplate(context: context)
                morning.id = UUID()
                morning.name = "Morning"
                
                let cleanser = SCRoutineStepTemplate(context: context)
                cleanser.id = UUID()
                cleanser.displayOrder = 0
                cleanser.productName = "Cleanser"
                cleanser.frequency = "Everyday"
                morning.addToSteps(cleanser)

                let moisturizer = SCRoutineStepTemplate(context: context)
                moisturizer.id = UUID()
                moisturizer.displayOrder = 1
                moisturizer.productName = "Moisturizer"
                moisturizer.frequency = "Everyday"
                morning.addToSteps(moisturizer)

                // Evening Routine
                let evening = SCRoutineTemplate(context: context)
                evening.id = UUID()
                evening.name = "Evening"
                
                let nightCleanser = SCRoutineStepTemplate(context: context)
                nightCleanser.id = UUID()
                nightCleanser.displayOrder = 0
                nightCleanser.productName = "Cleanser"
                nightCleanser.frequency = "Everyday"
                evening.addToSteps(nightCleanser)

                let treatment = SCRoutineStepTemplate(context: context)
                treatment.id = UUID()
                treatment.displayOrder = 1
                treatment.productName = "Treatment"
                treatment.frequency = "Alternate"
                evening.addToSteps(treatment)

                saveContext()
                print("Base routines created.")
            }
        } catch {
            print("Error checking base routines: \(error)")
        }
    }

    // MARK: - Generate Daily Routine From Template
    
    func generateDailyRoutine(for date: Date) -> SCDay {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)

        // Check if day exists
        let request: NSFetchRequest<SCDay> = SCDay.fetchRequest()
        request.predicate = NSPredicate(format: "date == %@", startOfDay as NSDate)
        request.fetchLimit = 1

        if let day = try? context.fetch(request).first {
            return day
        }

        // Create day
        let newDay = SCDay(context: context)
        newDay.id = UUID()
        newDay.date = startOfDay

        // Copy routines from template
        let templateRequest: NSFetchRequest<SCRoutineTemplate> = SCRoutineTemplate.fetchRequest()
        if let templates = try? context.fetch(templateRequest) {
            for tmpl in templates {
                let routine = SCRoutine(context: context)
                routine.id = UUID()
                routine.name = tmpl.name
                routine.isCompleted = false
                routine.day = newDay

                if let steps = tmpl.steps?.array as? [SCRoutineStepTemplate] {
                    for stepTemplate in steps {
                        // Handle frequency check here
                        if shouldIncludeStep(stepTemplate, for: date) {
                            let step = SCRoutineStep(context: context)
                            step.id = UUID()
                            step.displayOrder = stepTemplate.displayOrder
                            step.productName = stepTemplate.productName
                            step.frequency = stepTemplate.frequency
                            step.isCompleted = false
                            routine.addToSteps(step)
                        }
                    }
                }
            }
        }

        saveContext()
        return newDay
    }

    private func shouldIncludeStep(_ template: SCRoutineStepTemplate, for date: Date) -> Bool {
        switch template.frequency {
        case "Everyday":
            return true
        case "Alternate":
            // Simple example: include only on even days
            let day = Calendar.current.component(.day, from: date)
            return day % 2 == 0
        case "Weekly":
            // Example: include only on Sundays
            let weekday = Calendar.current.component(.weekday, from: date)
            return weekday == 1
        default:
            return true
        }
    }
}
