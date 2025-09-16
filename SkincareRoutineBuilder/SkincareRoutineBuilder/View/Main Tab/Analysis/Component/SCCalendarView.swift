//
//  SCCalendarView.swift
//  SkincareRoutineBuilder
//
//  Created by Dhruvil Moradiya on 16/09/25.
//

import SwiftUI

struct SCCalendarView: View {
    @State private var currentMonth: Date = Date()
    var startDate = UserDefaultManager.shared.startDate
    let today: Date = Date()
    
    var body: some View {
        VStack {
            // Header with arrows
            HStack {
                Button(action: { previousMonth() }) {
                    Image(systemName: "chevron.left")
                }
                .disabled(!canGoPreviousMonth)
                
                Spacer()
                
                Text(monthYearString(currentMonth))
                    .font(.headline)
                
                Spacer()
                
                Button(action: { nextMonth() }) {
                    Image(systemName: "chevron.right")
                }
                .disabled(!canGoNextMonth)
            }
            .padding(.horizontal)
            
            // Calendar Grid
            let days = generateDays(for: currentMonth)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                // Weekday headers
                ForEach(weekdays(), id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                
                // Calendar days
                ForEach(days, id: \.self) { date in
                    if let date = date {
                        let isWithinRange = isDateInRange(date)
                        Text("\(Calendar.current.component(.day, from: date))")
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(isWithinRange ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                            .clipShape(Circle())
                            .foregroundColor(isWithinRange ? .primary : .secondary)
                    } else {
                        Text("") // Empty cell for alignment
                            .frame(maxWidth: .infinity, minHeight: 40)
                    }
                }
            }
            .padding()
        }
    }
    
    // MARK: - Navigation
    
    private func previousMonth() {
        currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
    }
    
    private func nextMonth() {
        currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
    }
    
    private var canGoPreviousMonth: Bool {
        let startOfStartDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: startDate))!
        return currentMonth > startOfStartDate
    }
    
    private var canGoNextMonth: Bool {
        let startOfToday = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: today))!
        return currentMonth < startOfToday
    }
    
    // MARK: - Helpers
    
    private func monthYearString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }
    
    private func weekdays() -> [String] {
        let formatter = DateFormatter()
        formatter.shortWeekdaySymbols = ["S", "M", "T", "W", "T", "F", "S"]
        return formatter.shortWeekdaySymbols
    }
    
    private func generateDays(for month: Date) -> [Date?] {
        let calendar = Calendar.current
        
        guard let monthInterval = calendar.dateInterval(of: .month, for: month),
              let firstWeekday = calendar.dateComponents([.weekday], from: monthInterval.start).weekday else {
            return []
        }
        
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        
        var currentDate = monthInterval.start
        while currentDate < monthInterval.end {
            days.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return days
    }
    
    private func isDateInRange(_ date: Date) -> Bool {
        let calendar = Calendar.current
        let d = calendar.startOfDay(for: date)
        return d >= calendar.startOfDay(for: startDate) && d <= calendar.startOfDay(for: today)
    }
}
