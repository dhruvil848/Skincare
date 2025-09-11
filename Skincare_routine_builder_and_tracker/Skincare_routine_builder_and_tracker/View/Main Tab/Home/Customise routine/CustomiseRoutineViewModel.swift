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
        if routine.name?.contains("Morning") == true {
            
        } else {
            
        }
        
        let viewModel = AddProductViewModel()
        viewModel.isForEdit = false
        
        NavigationManager.shared.push(to: .addProductView(destination: AddProductViewDestination(viewModel: viewModel)))
    }
}
