//
//  CustomiseRoutineViewModel.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 11/09/25.
//

import Foundation

class CustomiseRoutineViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var scDay: SCTemplateDay?    // Editable copy for UI
    @Published var refreshId: UUID = UUID()
    
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""

    
    // MARK: - Methods
    func onAppear() {
        initialize()
    }
    
    func initialize() {
        fetchTodayRoutine()
    }
    
    func fetchTodayRoutine() {
        scDay = CoreDataManager.shared.fetchTemplateDay()
        refreshId = UUID()
    }
    
    func deleteStep(from routine: SCTemplateRoutine, indexSet: IndexSet) {
        guard var steps = routine.steps?.array as? [SCTemplateRoutineStep] else { return }
        guard steps.count != 1 else {
            refreshId = UUID()
            self.showAlert(title: "Action Not Allowed", message: "Routine must have at least one step. You cannot delete this step.")
            return
        }
        
        // Remove steps at given indices
        for index in indexSet.sorted(by: >) { // Remove from highest to lowest
            steps.remove(at: index)
        }

        // Reassign displayOrder
        for (i, step) in steps.enumerated() {
            step.displayOrder = Int16(i)
        }

        // Update Core Data relationship
        routine.steps = NSOrderedSet(array: steps)

        // Save context
        CoreDataManager.shared.saveContext()

        // Refresh UI if needed
        refreshId = UUID()
    }

    func moveStep(in routine: SCTemplateRoutine,
                  from source: IndexSet,
                  to destination: Int) {
        guard let steps = routine.steps?.array as? [SCTemplateRoutineStep] else { return }

        var mutableSteps = steps
        mutableSteps.move(fromOffsets: source, toOffset: destination)

        routine.steps = NSOrderedSet(array: mutableSteps)

        CoreDataManager.shared.saveContext()
        refreshId = UUID()
    }
    
    // MARK: - Actions
    func btnBackAction() {
        NavigationManager.shared.pop()
    }
    
    func btnAddProductAction(routine: SCTemplateRoutine) {
        openAddProductView(isForEdit: false, routine: routine, routineStep: nil)
    }
    
    func openAddProductView(isForEdit: Bool, routine: SCTemplateRoutine, routineStep: SCTemplateRoutineStep?) {
        let viewModel = AddProductViewModel(routine: routine, routineStep: routineStep, isForEdit: isForEdit)
        NavigationManager.shared.push(to: .addProductView(destination: AddProductViewDestination(viewModel: viewModel)))
    }
    
    func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
