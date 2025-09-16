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

extension AnalysisViewModel {
    func statusColor(for date: Date) -> Color {
        guard let day = CoreDataManager.shared.fetchDay(for: date) else {
            return Color.gray.opacity(0.3)
        }
        
        guard let routines = day.routines?.array as? [SCRoutine], !routines.isEmpty else {
            return Color.gray.opacity(0.3)
        }
        
        let completedCount = routines.filter { $0.isCompleted }.count
        
        if completedCount == routines.count {
            return Color.scPurple
        } else if completedCount > 0 {
            return Color.orange
        } else {
            return Color.gray
        }
    }
}
