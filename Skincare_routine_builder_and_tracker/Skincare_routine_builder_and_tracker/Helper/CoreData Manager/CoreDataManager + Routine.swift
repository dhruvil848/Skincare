////
////  CoreDataManager + Routine.swift
////  Skincare_routine_builder_and_tracker
////
////  Created by Dhruvil Moradiya on 10/09/25.
////
//
//import CoreData
//
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
}

//
//    func fetchToday() -> SCDay {
//        let calendar = Calendar.current
//        let todayStart = calendar.startOfDay(for: Date())
//        let tomorrow = calendar.date(byAdding: .day, value: 1, to: todayStart)!
//        let baseTemplateDay = fetchTemplateDay()
//        
//        // 2. Fetch today's SCDay
//        let fetchRequest: NSFetchRequest<SCDay> = SCDay.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", todayStart as NSDate, tomorrow as NSDate)
//        fetchRequest.fetchLimit = 1
//        
//        let existingDay = try? context.fetch(fetchRequest).first
//        
//        // 3. If exists → sync with template
//        if let day = existingDay {
//            syncDay(day, with: baseTemplateDay)
//            saveContext()
//            return day
//        }
//        
//        // 4. Else → create new day
//        let newDay = SCDay(context: context)
//        newDay.id = UUID()
//        newDay.date = todayStart
//        newDay.isCompleted = false
//        
//        syncDay(newDay, with: baseTemplateDay)
//        saveContext()
//        return newDay
//    }
//    
//    private func syncDay(_ scDay: SCDay, with templateDay: SCTemplateDay) {
//        for case let tmplRoutine as SCTemplateRoutine in templateDay.routines ?? [] {
//            let routine = fetchOrCreateRoutine(from: tmplRoutine, in: scDay)
//            
//            var orderedSteps: [SCRoutineStep] = []
//            for case let tmplStep as SCTemplateRoutineStep in tmplRoutine.steps ?? [] {
//                let step = fetchOrCreateStep(from: tmplStep, in: routine)
//                
//                if let product = step.product, shouldShowProductToday(product) {
//                    orderedSteps.append(step)
//                }
//            }
//            routine.steps = NSOrderedSet(array: orderedSteps)
//        }
//        
//        saveContext()
//    }
//
//    private func fetchOrCreateDay(for date: Date) -> SCDay {
//        let fetch: NSFetchRequest<SCDay> = SCDay.fetchRequest()
//        fetch.predicate = NSPredicate(format: "date == %@", date as CVarArg)
//
//        fetch.fetchLimit = 1
//        
//        if let existing = try? context.fetch(fetch).first {
//            return existing
//        }
//        
//        let day = SCDay(context: context)
//        day.id = UUID()
//        day.date = date
//        day.isCompleted = false
//        return day
//    }
//
//    private func fetchOrCreateRoutine(from tmplRoutine: SCTemplateRoutine, in scDay: SCDay) -> SCRoutine {
//        guard let tmplId = tmplRoutine.id else { fatalError("TemplateRoutine missing id") }
//
//        let fetch: NSFetchRequest<SCRoutine> = SCRoutine.fetchRequest()
//        fetch.predicate = NSPredicate(format: "templateId == %@", tmplId as CVarArg, scDay)
//        fetch.fetchLimit = 1
//        
//        if let existing = try? context.fetch(fetch).first {
//            existing.name = tmplRoutine.name
//            existing.day = scDay
//            return existing
//        }
//        
//        let routine = SCRoutine(context: context)
//        routine.id = UUID()
//        routine.templateId = tmplId
//        routine.name = tmplRoutine.name
//        routine.isCompleted = false
//        routine.day = scDay
//        return routine
//    }
//
//    private func fetchOrCreateStep(from tmplStep: SCTemplateRoutineStep, in routine: SCRoutine) -> SCRoutineStep {
//        let fetch: NSFetchRequest<SCRoutineStep> = SCRoutineStep.fetchRequest()
//        fetch.predicate = NSPredicate(format: "templateId == %@ AND routine == %@", tmplStep.id! as CVarArg, routine)
//        fetch.fetchLimit = 1
//        
//        if let existing = try? context.fetch(fetch).first {
//            existing.displayOrder = tmplStep.displayOrder
//            existing.product = fetchOrCreateProduct(from: tmplStep.product!)
//            return existing
//        }
//        
//        let step = SCRoutineStep(context: context)
//        step.id = UUID()
//        step.templateId = tmplStep.id
//        step.displayOrder = tmplStep.displayOrder
//        step.isCompleted = false
//        step.product = fetchOrCreateProduct(from: tmplStep.product!)
//        return step
//    }
//
//
//
//    private func fetchOrCreateProduct(from tmplProduct: SCTemplateProduct) -> SCProduct {
//        guard let templateId = tmplProduct.id else {
//            fatalError("TemplateProduct is missing an id. You must assign UUID() when creating it.")
//        }
//        
//        let fetch: NSFetchRequest<SCProduct> = SCProduct.fetchRequest()
//        fetch.predicate = NSPredicate(format: "templateId == %@", templateId as CVarArg)
//        fetch.fetchLimit = 1
//        
//        if let existing = try? context.fetch(fetch).first {
//            existing.name = tmplProduct.name
//            existing.type = tmplProduct.type
//            existing.frequency = tmplProduct.frequency
//            existing.timeOfDay = tmplProduct.timeOfDay
//            return existing
//        }
//        
//        let product = SCProduct(context: context)
//        product.id = UUID()
//        product.templateId = templateId
//        product.name = tmplProduct.name
//        product.type = tmplProduct.type
//        product.frequency = tmplProduct.frequency
//        product.timeOfDay = tmplProduct.timeOfDay
//        return product
//    }
//    
//    private func shouldShowProductToday(_ product: SCProduct, today: Date = Date()) -> Bool {
//        let calendar = Calendar.current
//        guard let startDate = product.startDate else { return true } // fallback to always include
//
//        switch product.frequency ?? "Everyday" {
//        case "Everyday":
//            return true
//
//        case "Alternate day":
//            let daysSinceStart = calendar.dateComponents([.day], from: startDate, to: today).day ?? 0
//            return daysSinceStart % 2 == 0 // show only on alternate days
//
//        case "Once in week":
//            let startWeekday = calendar.component(.weekday, from: startDate)
//            let todayWeekday = calendar.component(.weekday, from: today)
//            return startWeekday == todayWeekday // show only on the same weekday as start date
//
//        default:
//            return true
//        }
//    }
//}

import CoreData
import Foundation

extension CoreDataManager {

    func fetchToday() -> SCDay {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: todayStart)!

        // 1. Fetch today's day
        let fetchRequest: NSFetchRequest<SCDay> = SCDay.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", todayStart as NSDate, tomorrow as NSDate)
        fetchRequest.fetchLimit = 1
        
        let existingDay = try? context.fetch(fetchRequest).first
        
        // 2. Fetch template day
        let templateDay = fetchTemplateDay()
        
        if let day = existingDay {
            // Sync today's routines/steps/products with template metadata
            syncDay(day, with: templateDay)
            saveContext()
            return day
        }
        
        // 3. Create new day if not exists
        let newDay = SCDay(context: context)
        newDay.id = UUID()
        newDay.date = todayStart
        newDay.isCompleted = false
        
        // Sync routines/steps/products from template
        syncDay(newDay, with: templateDay)
        saveContext()
        
        return newDay
    }

    private func syncDay(_ scDay: SCDay, with templateDay: SCTemplateDay) {
        for case let tmplRoutine as SCTemplateRoutine in templateDay.routines ?? [] {
            let routine = fetchOrCreateRoutine(from: tmplRoutine, in: scDay)
            
            var orderedSteps: [SCRoutineStep] = []
            for case let tmplStep as SCTemplateRoutineStep in tmplRoutine.steps ?? [] {
                let step = fetchOrCreateStep(from: tmplStep, in: routine)
                
                if let product = step.product, shouldShowProductToday(product) {
                    orderedSteps.append(step)
                }
            }
            routine.steps = NSOrderedSet(array: orderedSteps)
        }
        saveContext()
    }

    
    private func fetchOrCreateRoutine(from tmplRoutine: SCTemplateRoutine, in scDay: SCDay) -> SCRoutine {
        // Fetch routine for today using scDay
        let fetch: NSFetchRequest<SCRoutine> = SCRoutine.fetchRequest()
        fetch.predicate = NSPredicate(format: "day == %@ AND name == %@", scDay, tmplRoutine.name ?? "")
        fetch.fetchLimit = 1
        
        if let existing = try? context.fetch(fetch).first {
            // Sync routine metadata from template
            existing.name = tmplRoutine.name
            return existing
        }
        
        // Create new routine for today
        let routine = SCRoutine(context: context)
        routine.id = UUID()
        routine.templateId = tmplRoutine.id // optional: only for reference
        routine.name = tmplRoutine.name
        routine.isCompleted = false
        routine.day = scDay
        return routine
    }

    private func fetchOrCreateStep(from tmplStep: SCTemplateRoutineStep, in routine: SCRoutine) -> SCRoutineStep {
        // Fetch step using routine and displayOrder
        let fetch: NSFetchRequest<SCRoutineStep> = SCRoutineStep.fetchRequest()
        fetch.predicate = NSPredicate(format: "routine == %@ AND displayOrder == %d", routine, tmplStep.displayOrder)
        fetch.fetchLimit = 1
        
        if let existing = try? context.fetch(fetch).first {
            existing.displayOrder = tmplStep.displayOrder
            existing.product = fetchOrCreateProduct(from: tmplStep.product!, for: existing)
            return existing
        }
        
        // Create new step for today
        let step = SCRoutineStep(context: context)
        step.id = UUID()
        step.displayOrder = tmplStep.displayOrder
        step.isCompleted = false
        step.product = fetchOrCreateProduct(from: tmplStep.product!, for: step)
        step.routine = routine
        return step
    }

    private func fetchOrCreateProduct(from tmplProduct: SCTemplateProduct, for step: SCRoutineStep) -> SCProduct {
        // Fetch product using step reference
        let fetch: NSFetchRequest<SCProduct> = SCProduct.fetchRequest()
        fetch.predicate = NSPredicate(format: "step == %@", step)
        fetch.fetchLimit = 1
        
        if let existing = try? context.fetch(fetch).first {
            existing.name = tmplProduct.name
            existing.type = tmplProduct.type
            existing.frequency = tmplProduct.frequency
            existing.timeOfDay = tmplProduct.timeOfDay
            return existing
        }
        
        // Create new product for today
        let product = SCProduct(context: context)
        product.id = UUID()
        product.name = tmplProduct.name
        product.type = tmplProduct.type
        product.frequency = tmplProduct.frequency
        product.timeOfDay = tmplProduct.timeOfDay
        return product
    }
    
    private func shouldShowProductToday(_ product: SCProduct, today: Date = Date()) -> Bool {
        let calendar = Calendar.current
        guard let startDate = product.startDate else { return true } // fallback to always include

        switch product.frequency ?? "Everyday" {
        case "Everyday":
            return true

        case "Alternate day":
            let daysSinceStart = calendar.dateComponents([.day], from: startDate, to: today).day ?? 0
            return daysSinceStart % 2 == 0 // show only on alternate days

        case "Once in week":
            let startWeekday = calendar.component(.weekday, from: startDate)
            let todayWeekday = calendar.component(.weekday, from: today)
            return startWeekday == todayWeekday // show only on the same weekday as start date

        default:
            return true
        }
    }

}
