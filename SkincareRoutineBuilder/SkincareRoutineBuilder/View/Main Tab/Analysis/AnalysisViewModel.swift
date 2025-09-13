//
//  AnalysisViewModel.swift
//  SkincareRoutineBuilder
//
//  Created by Dhruvil Moradiya on 13/09/25.
//

import SwiftUI



// MARK: - Supporting Types
enum AnalysisTab: String, CaseIterable {
    case calendar = "Calendar"
    case stats = "Stats"
    case journal = "Journal"
}

class AnalysisViewModel: ObservableObject {
    
    @Published var scTemplateDay: SCTemplateDay?
    
    @Published var selectedTab: Int = 0
    @Published var currentMonth = Date()
    
    func onAppear() {
        initialization()
    }
    
    func initialization() {
        fetchTodayRoutine()
        loadCalendarData()
    }
    
    func fetchTodayRoutine() {
        scTemplateDay = CoreDataManager.shared.fetchTemplateDay()

    }
        
    func loadCalendarData() {
        let day = CoreDataManager.shared.fetchDays(from: UserDefaultManager.shared.startDate, to: Date())
        print(day.count)
    }
    
}
