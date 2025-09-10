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
    
    
    // MARK: - Methods
    func onAppear() {
        intialize()
    }
    
    func intialize() {
        fetchTodayRoutine()
    }
    
    func fetchTodayRoutine() {
        scTemplateDay = CoreDataManager.shared.fetchTemplateDay()
        scDay = CoreDataManager.shared.fetchToday()
        
        print("Date: \(String(describing: scDay?.date))")
        print("Routine: \(String(describing: scDay?.routines))")

    }
    
    func btnSelectRoutine(routine: SCRoutine, step: SCRoutineStep) {
        scDay = CoreDataManager.shared.selectRoutine(day: scDay, routine: routine, step: step)
    }
    
    func streakMessage() -> String {
        guard let completedDays = scTemplateDay?.streak else { return "" }

        switch completedDays {
        case 0:
            return "Let's start your first routine! 🌱"
        case 1:
            return "Great! You've taken the first step. 👏"
        case 2:
            return "Good going! Keep the momentum. 🔥"
        case 3:
            return "Halfway through the week! Keep it up! 💪"
        case 4:
            return "Awesome! You're on a roll! ✨"
        case 5:
            return "Impressive! Almost there! 🌟"
        case 6:
            return "Just one more day to complete the week! 🏁"
        case 7:
            return "Amazing! You completed the week! Take a moment to celebrate! 🎉"
        case 8...10:
            return "Unstoppable! You're building a strong habit! 💯"
        case 11...14:
            return "Legendary streak! Your skin routine is solid! 🏆"
        case 15...20:
            return "Epic! Your consistency is inspiring! 🌟"
        default:
            return "Keep your streak alive! Consistency is key! 💖"
        }
    }
    
    func greetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch 24 {
        case 5..<12:
            return "Good Morning! 👋🏻"
        case 12..<17:
            return "Good Afternoon! 👋🏻"
        case 17..<21:
            return "Good Evening! 👋🏻"
        default:
            return "Good Night! 👋🏻"
        }
    }

}
