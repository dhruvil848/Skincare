//
//  AddProductViewModel.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 11/09/25.
//

import SwiftUI

class AddProductViewModel: ObservableObject {
    
    @Published var productName: String = ""
    @Published var productType: String = ""
    @Published var timeOfDay: String = ""
    @Published var frequency: String = ""
    @Published var isForEdit: Bool = false
    
    private var routineStep: SCRoutineStep?
    
    func onAppear() {
        inintialization()
    }
    
    func inintialization() {
        productName = routineStep?.productName ?? ""
    }
    
    // MARK: - Actions
    func btnBackAction() {
        NavigationManager.shared.pop()
    }
}
