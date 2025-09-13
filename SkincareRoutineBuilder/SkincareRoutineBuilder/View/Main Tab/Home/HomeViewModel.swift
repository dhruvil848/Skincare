//
//  HomeViewModel.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    // MARK: - Variables
    @Published var scTemplateDay: SCTemplateDay?
    @Published var scDay: SCDay?
    @Published var showStrekAnimation: Bool = false
    
    // MARK: - Methods
    func onAppear() {
        initialize()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white // default color
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func initialize() {
        fetchTodayRoutine()
    }
    
    func fetchTodayRoutine() {
        scTemplateDay = CoreDataManager.shared.fetchTemplateDay()
        scDay = CoreDataManager.shared.fetchToday()
        
        print("Date: \(String(describing: scDay?.date))")
        print("Routine: \(String(describing: scDay?.routines))")

    }
    
    // MARK: - Actions
    func btnSelectRoutine(routine: SCRoutine, step: SCRoutineStep) {
        (scDay, showStrekAnimation) = CoreDataManager.shared.selectRoutine(day: scDay, routine: routine, step: step)
    }
    
    func btnCustomiseRoutineAction() {
        NavigationManager.shared.push(to: .customiseRoutineView)
    }
}
