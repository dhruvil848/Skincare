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
    
    init(routineStep: SCTemplateRoutineStep? = nil) {
        self.routineStep = routineStep
        self.productName = routineStep?.product?.name ?? ""
        self.timeOfDay = routineStep?.routine?.name ?? ""
        self.frequency = routineStep?.product?.frequency ?? ""
    }
    
    func saveProduct() {
        
    }
    
    // MARK: - Actions
    func btnBackAction() {
        NavigationManager.shared.pop()
    }
    
    func btnSaveAction() {
        
    }
}
