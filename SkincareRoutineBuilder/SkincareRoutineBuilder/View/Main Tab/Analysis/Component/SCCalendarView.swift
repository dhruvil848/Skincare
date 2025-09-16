//
//  SCCalendarView.swift
//  SkincareRoutineBuilder
//
//  Created by Dhruvil Moradiya on 16/09/25.
//

import SwiftUI

struct SCCalendarView: View {
    @ObservedObject var viewModel: AnalysisViewModel
    @State private var currentMonth: Date = Date()
    
    var startDate = UserDefaultManager.shared.startDate
    let today: Date = Date()

    var body: some View {
        VStack {
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
            .padding(20)
            
            // Calendar Grid
            let days = generateDays(for: currentMonth)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 12) {
                // Weekday headers
                ForEach(weekdays(), id: \.self) { day in
                    Text(day)
                        .font(.system(size: 14, weight: .light, design: .default))
                        .frame(maxWidth: .infinity)
                }
                
                // Calendar days
                ForEach(days, id: \.self) { date in
                    if let date = date {
                        let isInRange = isDateInRange(date)
                        let borderColor = isInRange ? viewModel.statusColor(for: date) : Color.gray.opacity(0.3)
                        let textColor = isInRange ? borderColor : Color.gray.opacity(0.4)
                        let isToday = Calendar.current.isDateInToday(date)

                        VStack(spacing: 4) {
                            Text("\(Calendar.current.component(.day, from: date))")
                                .font(.system(size: 13, weight: .medium, design: .default))
                                .frame(maxWidth: .infinity, minHeight: 24)
                                .foregroundColor(textColor)
                        }
                        .padding(5)
                        .background(
                            Circle()
                                .stroke(borderColor, lineWidth: isToday ? 1.5 : 1)
                                .background(
                                    Circle()
                                        .fill(isToday ? Color.purple.opacity(0.15) : Color.clear)
                                )
                        )
                    } else {
                        Text("")
                            .frame(maxWidth: .infinity, minHeight: 40)
                    }
                }

            }
            .padding(20)
        }
    }
    
    // MARK: - Navigation
    
    private var normalizedCurrentMonth: Date {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
    }

    private var canGoPreviousMonth: Bool {
        let calendar = Calendar.current
        let startOfStartMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: startDate))!
        return normalizedCurrentMonth > startOfStartMonth
    }

    private var canGoNextMonth: Bool {
        let calendar = Calendar.current
        let startOfTodayMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: today))!
        return normalizedCurrentMonth < startOfTodayMonth
    }

    // Navigation updates also normalize
    private func previousMonth() {
        if canGoPreviousMonth {
            if let newMonth = Calendar.current.date(byAdding: .month, value: -1, to: normalizedCurrentMonth) {
                currentMonth = newMonth
            }
        }
    }

    private func nextMonth() {
        if canGoNextMonth {
            if let newMonth = Calendar.current.date(byAdding: .month, value: 1, to: normalizedCurrentMonth) {
                currentMonth = newMonth
            }
        }
    }

    // MARK: - Helpers
    
    private func monthYearString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: date)
    }
    
    private func weekdays() -> [String] {
        let formatter = DateFormatter()
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
