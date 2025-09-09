//
//  HomeViewModel.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var scDay: SCDay?
    
    
    let todayDate = Date()
    
    // MARK: -
    func intialize() {
        scDay = CoreDataManager.shared.getDailyRoutine(for: todayDate)
    }
}
