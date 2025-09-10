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
            print("✅ Context saved")
        } catch {
            print("❌ Failed to save context: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch or Create Daily Routine
    func getDailyRoutine(for date: Date) -> SCDay {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)!

        let request: NSFetchRequest<SCDay> = SCDay.fetchRequest()
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", start as NSDate, end as NSDate)
        request.fetchLimit = 1

        do {
            if let existingDay = try context.fetch(request).first {
                return existingDay
            } else {
                return generateDailyRoutine(for: date)
            }
        } catch {
            print("❌ Failed to fetch SCDay: \(error)")
            return generateDailyRoutine(for: date)
        }
    }

    // MARK: - Create Base Routines (After Onboarding)
    func createBaseRoutineIfNeeded() {
        let fetchRequest: NSFetchRequest<SCTemplateDay> = SCTemplateDay.fetchRequest()

        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                // Morning Routine
                
                let day = SCTemplateDay(context: context)
                day.id = UUID()
                day.streak = 0
                
                let morning = SCTemplateRoutine(context: context)
                morning.id = UUID()
                morning.name = "Morning"
                
                let cleanser = SCTemplateRoutineStep(context: context)
                cleanser.id = UUID()
                cleanser.displayOrder = 0
                cleanser.productName = "Cleanser"
                cleanser.frequency = "Everyday"
                morning.addToSteps(cleanser)

                let moisturizer = SCTemplateRoutineStep(context: context)
                moisturizer.id = UUID()
                moisturizer.displayOrder = 1
                moisturizer.productName = "Moisturizer"
                moisturizer.frequency = "Everyday"
                morning.addToSteps(moisturizer)

                // Evening Routine
                let evening = SCTemplateRoutine(context: context)
                evening.id = UUID()
                evening.name = "Evening"
                
                let nightCleanser = SCTemplateRoutineStep(context: context)
                nightCleanser.id = UUID()
                nightCleanser.displayOrder = 0
                nightCleanser.productName = "Cleanser"
                nightCleanser.frequency = "Everyday"
                evening.addToSteps(nightCleanser)

                let treatment = SCTemplateRoutineStep(context: context)
                treatment.id = UUID()
                treatment.displayOrder = 1
                treatment.productName = "Treatment"
                treatment.frequency = "Alternate"
                evening.addToSteps(treatment)
                
                morning.day = day
                evening.day = day
                
                day.routines = [morning, evening]
                saveContext()
                print("✅ Base routines created.")
            }
        } catch {
            print("❌ Error checking base routines: \(error)")
        }
    }

    // MARK: - Generate Daily Routine From Template
    func generateDailyRoutine(for date: Date) -> SCDay {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: date)
        let end = calendar.date(byAdding: .day, value: 1, to: start)!

        // Check if day already exists
        let request: NSFetchRequest<SCDay> = SCDay.fetchRequest()
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", start as NSDate, end as NSDate)
        request.fetchLimit = 1

        if let day = try? context.fetch(request).first {
            return day
        }

        // Ensure templates exist
        createBaseRoutineIfNeeded()

        do {
            let templateDay = try context.fetch(SCTemplateDay.fetchRequest())
            let templateRoutines = templateDay.first?.routines as? [SCTemplateRoutine] ?? []
            
            // Create new day
            let newDay = SCDay(context: context)
            newDay.id = UUID()
            newDay.date = start

            // Copy routines from template
            for tmpl in templateRoutines {
                let routine = SCRoutine(context: context)
                routine.id = UUID()
                routine.name = tmpl.name
                routine.isCompleted = false
                routine.day = newDay

                if let steps = tmpl.steps?.array as? [SCTemplateRoutineStep] {
                    for stepTemplate in steps {
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
                
                newDay.addToRoutines(routine)
            }
            
            saveContext()
            return newDay

        } catch {
            print("❌ Failed to fetch templates: \(error)")
            // Return an empty newDay to avoid crash
            let fallbackDay = SCDay(context: context)
            fallbackDay.id = UUID()
            fallbackDay.date = start
            saveContext()
            return fallbackDay
        }
    }

    // MARK: - Step Inclusion Rules
    private func shouldIncludeStep(_ template: SCTemplateRoutineStep, for date: Date) -> Bool {
        switch template.frequency {
        case "Everyday":
            return true
        case "Alternate":
            let day = Calendar.current.component(.day, from: date)
            return day % 2 == 0
        case "Weekly":
            let weekday = Calendar.current.component(.weekday, from: date)
            return weekday == 1
        default:
            return true
        }
    }
}
