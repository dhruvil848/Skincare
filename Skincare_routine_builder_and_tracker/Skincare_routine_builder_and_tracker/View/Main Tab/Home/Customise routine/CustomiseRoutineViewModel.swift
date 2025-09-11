//
//  CustomiseRoutineViewModel.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 11/09/25.
//

import SwiftUI

class CustomiseRoutineViewModel: ObservableObject {

    // MARK: - Variables
    @Published var scTemplateDay: SCTemplateDay?
    
    // MARK: - Methods
    func onAppear() {
        initialize()
    }
    
    func initialize() {
        fetchTodayRoutine()
    }
    
    func fetchTodayRoutine() {
        scTemplateDay = CoreDataManager.shared.fetchTemplateDay()
    }
    
    // MARK: - Actions
    func btnBackAction() {
        NavigationManager.shared.pop()
    }
    
    func btnSaveAction() {
        
    }
}
