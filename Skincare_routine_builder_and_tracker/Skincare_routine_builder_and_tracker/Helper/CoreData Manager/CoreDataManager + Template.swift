//
//  CoreDataManager + Templae.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 10/09/25.
//

import CoreData

extension CoreDataManager {
    
    func fetchTemplateDay() -> SCTemplateDay {
        var templateDay: SCTemplateDay?
        let templateFetch: NSFetchRequest<SCTemplateDay> = SCTemplateDay.fetchRequest()
        let arrTemplates = try? context.fetch(templateFetch)
        
        if let first = arrTemplates?.first {
            createBaseRoutineIfNeeded()
            templateDay = first
        }
        
        guard let baseTemplateDay = templateDay else {
            fatalError("❌ Could not create or fetch template day.")
        }
        
        return baseTemplateDay
    }
    
    func updateStreakIfNeeded(for day: SCDay) {
        guard let routines = day.routines?.array as? [SCRoutine], !routines.isEmpty else { return }
        let allRoutinesCompleted = routines.allSatisfy { $0.isCompleted }
        
        if allRoutinesCompleted && day.isCompleted == false {
            day.isCompleted = true
            
            let templateDay = fetchTemplateDay()
            templateDay.streak += 1
            print("🔥 Streak incremented: \(templateDay.streak)")
            saveContext()
        }
    }
    
    func getCompletedDaysThisWeek() -> Int {
        let calendar = Calendar.current
        let today = Date()
        
        // Get the start of the current week (e.g., Monday or Sunday depending on locale)
        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: today)?.start else {
            return 0
        }
        let weekEnd = calendar.date(byAdding: .day, value: 7, to: weekStart)!
        
        let fetchRequest: NSFetchRequest<SCDay> = SCDay.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", weekStart as NSDate, weekEnd as NSDate)
        
        do {
            let days = try context.fetch(fetchRequest)
            return days.filter { $0.isCompleted }.count
        } catch {
            print("❌ Failed to fetch week days: \(error)")
            return 0
        }
    }
    
    // MARK: - Create Base Routines (After Onboarding)
    func createBaseRoutineIfNeeded() {
        let fetchRequest: NSFetchRequest<SCTemplateDay> = SCTemplateDay.fetchRequest()

        do {
            let count = try context.count(for: fetchRequest)
            if count == 0 {
                let baseDay = SCTemplateDay(context: context)
                baseDay.id = UUID()
                baseDay.streak = 0

                let morningRoutine = createMorningBaseRoutine(baseDay: baseDay)
                let eveningRoutine = createEveningBaseRoutine(baseDay: baseDay)
                
                baseDay.addToRoutines(morningRoutine)
                baseDay.addToRoutines(eveningRoutine)

                saveContext()
                print("✅ Base routines created.")
            }
        } catch {
            print("❌ Error checking base routines: \(error)")
        }
    }
    
    func createMorningBaseRoutine(baseDay: SCTemplateDay) -> SCTemplateRoutine {
        // Morning Routine
        let morning = SCTemplateRoutine(context: context)
        morning.id = UUID()
        morning.name = "☀️ Morning"
        morning.day = baseDay

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
        
        return morning
    }
    
    func createEveningBaseRoutine(baseDay: SCTemplateDay) -> SCTemplateRoutine {
        // Evening Routine
        let evening = SCTemplateRoutine(context: context)
        evening.id = UUID()
        evening.name = "🌙 Evening"
        evening.day = baseDay

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
        
        return evening
    }
}
