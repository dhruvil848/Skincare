//
//  NavigationDestination.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import Foundation

enum NavigationDestination: Hashable {
    // Onboarding
    case whatSkinTypeView
    case whatSkinConcernView
    case whatGoalView
    case yourRoutineReadyView
    
    // Main Tab
    case customiseRoutineView
    case addProductView(destination: AddProductViewDestination)
}

class AddProductViewDestination: Hashable {
    
    let id = 1
    let viewModel: AddProductViewModel
    
    init(viewModel: AddProductViewModel) {
        self.viewModel = viewModel
    }
    
    static func == (lhs: AddProductViewDestination, rhs: AddProductViewDestination) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
