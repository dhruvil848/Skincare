//
//  NavigationRouter.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import SwiftUI

enum NavigationRouter {
    
    @ViewBuilder
    static func destinationView(destination: NavigationDestination) -> some View {
        switch destination {
            
        // Onboarding
        case .whatSkinTypeView:
            WhatSkinTypeView()
            
        case .whatSkinConcernView:
            WhatSkinConcernView()
            
        case .whatGoalView:
            WhatGoalView()
            
        case .yourRoutineReadyView:
            YourRoutineReadyView()
            
        // Main tab
        case .customiseRoutineView:
            CustomiseRoutineView()
            
        case .addProductView(let destination):
            AddProductView(viewModel: destination.viewModel)
        }
    }
}
