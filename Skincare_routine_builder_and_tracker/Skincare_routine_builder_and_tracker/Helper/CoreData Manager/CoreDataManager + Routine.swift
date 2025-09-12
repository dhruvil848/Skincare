//
//  CoreDataManager + Routine.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 10/09/25.
//

import CoreData

extension CoreDataManager {
    
    func selectRoutine(day: SCDay?, routine: SCRoutine, step: SCRoutineStep) -> SCDay? {
        guard let day = day else { return nil }
        
        if let routines = day.routines?.array as? [SCRoutine],
           let routineIndex = routines.firstIndex(of: routine),
           let steps = routines[routineIndex].steps?.array as? [SCRoutineStep],
           let stepIndex = steps.firstIndex(of: step) {
            
            // Check - Uncheck routine step
            let targetStep = steps[stepIndex]
            targetStep.isCompleted.toggle()
            
            // Mark current routine as completed
            let allStepsDone = steps.allSatisfy { $0.isCompleted }
            routines[routineIndex].isCompleted = allStepsDone
        }
        
        saveContext()
        updateStreakIfNeeded(for: day)
        
        return day
    }
    
    // MARK: - Routine Completion Percentage
    func routineCompletionPercentage(for routine: SCRoutine) -> Double {
        guard let steps = routine.steps?.array as? [SCRoutineStep], !steps.isEmpty else { return 0 }
        
        let completedSteps = steps.filter { $0.isCompleted }.count
        return (Double(completedSteps) / Double(steps.count)) * 100
    }

    func fetchToday() -> SCDay {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: todayStart)!
        let baseTemplateDay = fetchTemplateDay()
        
        // 2. Fetch today's SCDay
        let fetchRequest: NSFetchRequest<SCDay> = SCDay.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", todayStart as NSDate, tomorrow as NSDate)
        fetchRequest.fetchLimit = 1
        
        let existingDay = try? context.fetch(fetchRequest).first
        
        // 3. If exists → sync with template
        if let day = existingDay {
            syncDay(day, with: baseTemplateDay)
            saveContext()
            return day
        }
        
        // 4. Else → create new day
        let newDay = SCDay(context: context)
        newDay.id = UUID()
        newDay.date = todayStart
        newDay.isCompleted = false
        
        syncDay(newDay, with: baseTemplateDay)
        saveContext()
        return newDay
    }
    
    private func syncDay(_ scDay: SCDay, with templateDay: SCTemplateDay) {
        // --- Sync routines ---
        let existingRoutines = (scDay.routines?.array as? [SCRoutine]) ?? []
        
        // Map for quick lookup
        var existingRoutinesByKey = [String: SCRoutine]()
        for routine in existingRoutines {
            existingRoutinesByKey[routine.id?.uuidString ?? UUID().uuidString] = routine
        }
        
        // Track which routines should remain
        var validRoutines = Set<SCRoutine>()
        
        for case let tmplRoutine as SCTemplateRoutine in templateDay.routines ?? [] {
            let routine: SCRoutine
            
            if let existing = existingRoutinesByKey[tmplRoutine.id?.uuidString ?? UUID().uuidString] {
                routine = existing
            } else {
                routine = SCRoutine(context: context)
                routine.id = UUID()
                routine.name = tmplRoutine.name
                routine.isCompleted = false
                routine.day = scDay
                scDay.addToRoutines(routine)
            }
            
            validRoutines.insert(routine)
            
            // --- Sync steps in template order ---
            let existingSteps = (routine.steps?.array as? [SCRoutineStep]) ?? []
            var existingStepsByKey = [String: SCRoutineStep]()
            
            for step in existingSteps {
                if let id = step.id?.uuidString {
                    existingStepsByKey[id] = step
                }
            }
            
            var orderedSteps = [SCRoutineStep]()
            
            for case let tmplStep as SCTemplateRoutineStep in tmplRoutine.steps ?? [] {
                let key = tmplStep.id?.uuidString ?? UUID().uuidString
                let step: SCRoutineStep
                
                if let existingStep = existingStepsByKey[key] {
                    step = existingStep
                    // Update mutable fields without touching isCompleted
                    if tmplStep.product != nil {
                        step.product = cloneProduct(from: tmplStep.product!)
                    }
                    step.displayOrder = tmplStep.displayOrder
                } else {
                    step = SCRoutineStep(context: context)
                    step.id = tmplStep.id // copy template id
                    
                    if tmplStep.product != nil {
                        step.product = cloneProduct(from: tmplStep.product!)
                    }
                    step.displayOrder = tmplStep.displayOrder
                    step.isCompleted = false
                    step.routine = routine
                }
                
                orderedSteps.append(step)
            }
            
            // Assign steps in template order
            routine.steps = NSOrderedSet(array: orderedSteps)
            
            // Remove steps not in template
            for step in existingSteps {
                if !orderedSteps.contains(step) {
                    context.delete(step)
                }
            }
        }
        
        // Remove routines not in template
        for routine in existingRoutines {
            if !validRoutines.contains(routine) {
                context.delete(routine)
            }
        }
    }
    
    private func cloneProduct(from templateProduct: SCTemplateProduct) -> SCProduct {
        let product = SCProduct(context: context)
        product.id = UUID()
        product.name = templateProduct.name
        product.type = templateProduct.type
        product.frequency = templateProduct.frequency
        product.timeOfDay = templateProduct.timeOfDay
        return product
    }
}
