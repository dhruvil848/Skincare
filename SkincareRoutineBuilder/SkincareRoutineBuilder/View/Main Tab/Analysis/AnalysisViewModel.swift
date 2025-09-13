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
    @Published var selectedDay: SCDay?
    
    @Published var selectedTab: Int = 0
    @Published var selectedDateInCalendar = Date()
    
    let startDate = UserDefaultManager.shared.startDate
    var endDate: Date {
        return Date()
    }
    
    var isSelectedDateToday: Bool {
        return Calendar.current.isDateInToday(selectedDateInCalendar)
    }
    
    let currentDayColor: Color = Color.scPurple
    let bothRoutineCompletedColor: Color = Color.init(hex: "00AA00")
    let oneRoutineCompletedColor: Color = Color.init(hex: "FF7300")
    let noRoutineCompletedColor: Color = Color.gray
    let otherDayColor: Color = Color.secondary
    
    func onAppear() {
        initialization()
    }
    
    func initialization() {
        selectedDateInCalendar = Date()
        fetchTodayRoutine()
        loadSelectedDay(from: selectedDateInCalendar)
    }
    
    func fetchTodayRoutine() {
        scTemplateDay = CoreDataManager.shared.fetchTemplateDay()
    }
        
    func loadSelectedDay(from date: Date) {
        guard isDateInRange(date) else {
            return
        }
        
        selectedDateInCalendar = date
        let days = CoreDataManager.shared.fetchDays(from: startDate, to: Date())
        
        if let selectedDay = days.first(where: { Calendar.current.isDate($0.date ?? Date(), inSameDayAs: date) }) {
            self.selectedDay = selectedDay
        } else {
            self.selectedDay = nil
        }
    }
    
    // MARK: - Action
    func btnSelectRoutine(routine: SCRoutine, step: SCRoutineStep) {
        selectedDay = CoreDataManager.shared.selectRoutine(day: selectedDay, routine: routine, step: step).day
    }
    
    func selectTab(at index: Int) {
        selectedTab = index
    }
}

extension AnalysisViewModel {
    func isDateInRange(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let d = calendar.startOfDay(for: date)
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        return d >= start && d <= end
    }
    
    func getDayColor(for date: Date) -> Color {
        if !isDateInRange(date) {
            return .gray.opacity(0.4)
        }
        
        let day = CoreDataManager.shared.fetchDay(for: date)
        
        guard let routines = day?.routines?.array as? [SCRoutine], !routines.isEmpty else {
            return noRoutineCompletedColor
        }
        
        let completedCount = routines.filter { $0.isCompleted }.count
        
        if completedCount == routines.count {
            return bothRoutineCompletedColor
        } else if completedCount > 0 {
            return oneRoutineCompletedColor
        } else {
            return noRoutineCompletedColor
        }
    }
    
}
