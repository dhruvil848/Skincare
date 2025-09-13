//
//  AddProductViewModel.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 11/09/25.
//

import SwiftUI

class AddProductViewModel: ObservableObject {
    
    @Published var productName: String = ""
    @Published var productType: String = "Face wash"
    @Published var timeOfDay: String = ""
    @Published var frequency: String = "Everyday"
    
    @Published var isForEdit: Bool = false
    @Published var disableTimeOfDay: Bool = false
    
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    
    private var routine: SCTemplateRoutine
    private var routineStep: SCTemplateRoutineStep?
    
    var arrProductType: [String] = [
        "Face wash",
        "Serum",
        "Toner",
        "Moisturizer",
        "Sunscreen",
        "Exfoliator",
        "Cleanser",
        "Night cream",
        "Eye cream",
        "Lip balm"
    ]
    
    var arrTime: [String] = [
        "Morning",
        "Evening"
    ]
    
    var arrFrequency: [String] = [
        "Everyday",
        "Alternate day",
        "Once in week"
    ]
    
    init(routine: SCTemplateRoutine, routineStep: SCTemplateRoutineStep? = nil, isForEdit: Bool) {
        self.routine = routine
        self.routineStep = routineStep
        self.isForEdit = isForEdit
        
        self.productName = routineStep?.product?.name ?? ""
        self.productType = routineStep?.product?.type ?? "Face wash"
        self.timeOfDay = routineStep?.product?.timeOfDay ?? ((routine.name?.contains(arrTime[0])) == true ? arrTime[0] : arrTime[1])
        self.frequency = routineStep?.product?.frequency ?? "Everyday"
        
        self.disableTimeOfDay = isForEdit == true ? (routine.steps?.count == 1) : false
    }
    
    func saveProduct() {
        defer {
            CoreDataManager.shared.saveContext()
            NavigationManager.shared.pop()
        }
        
        if let step = routineStep, let product = step.product {
            // --- Editing existing product ---
            
            let oldTimeOfDay = product.timeOfDay ?? ""
            
            // Update product fields
            product.name = productName
            product.type = productType
            product.frequency = frequency
            product.timeOfDay = timeOfDay
            
            // If timeOfDay changed, move step to correct routine
            if oldTimeOfDay != timeOfDay,
               let parentDay = routine.day,
               let routines = parentDay.routines?.array as? [SCTemplateRoutine] {
                
                // 1. Remove step from current routine
                if var currentSteps = routine.steps?.array as? [SCTemplateRoutineStep] {
                    currentSteps.removeAll { $0 == step }
                    // Reassign displayOrder for remaining steps
                    for (index, s) in currentSteps.enumerated() {
                        s.displayOrder = Int16(index)
                    }
                    routine.steps = NSOrderedSet(array: currentSteps)
                    step.routine = nil
                }
                
                // 2. Find target routine by timeOfDay
                if let targetRoutine = routines.first(where: { $0.name?.contains(timeOfDay) == true }) {
                    var targetSteps = (targetRoutine.steps?.array as? [SCTemplateRoutineStep]) ?? []
                    
                    // Add step at the end
                    targetSteps.append(step)
                    
                    // Reassign displayOrder sequentially
                    for (index, s) in targetSteps.enumerated() {
                        s.displayOrder = Int16(index)
                    }
                    
                    targetRoutine.steps = NSOrderedSet(array: targetSteps)
                    step.routine = targetRoutine
                } else {
                    print("⚠️ Warning: No routine found for timeOfDay '\(timeOfDay)'")
                }
            }
            
            return
            
        } else {
            guard let day = routine.day, let routines = day.routines?.array as? [SCTemplateRoutine], let routine = routines.first(where: { $0.name?.contains(timeOfDay) == true }) else { return }
            
            CoreDataManager.shared.addProductToTemplateRoutine(
                routine: routine,
                name: productName,
                type: productType,
                timeOfDay: timeOfDay,
                frequency: frequency
            )
        }
    }
    
    // MARK: - Actions
    func btnBackAction() {
        NavigationManager.shared.pop()
    }
    
    func btnSaveAction() {
        guard productName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false else {
            showAlert(title: "Missing Product Name", message: "Please enter a name for the product to proceed.")
            return
        }
        
        saveProduct()
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
