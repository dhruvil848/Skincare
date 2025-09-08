//
//  AppState.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import SwiftUI

enum AppFlow: String {
    case onBoarding
    case home
    case none
}

class AppState: ObservableObject {
    
    static let shared = AppState()
    @Published var flow: AppFlow = .none
    
    init() {
        updateFlow()
    }
    
    func updateFlow() {
        if UserDefaultManager.shared.isOnboardingFinished {
            flow = .home
        } else {
            flow = .onBoarding
        }
    }
}
