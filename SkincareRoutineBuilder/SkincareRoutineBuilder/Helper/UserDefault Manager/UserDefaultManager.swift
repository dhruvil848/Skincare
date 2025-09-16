//
//  UserDefaultManager.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//


import Foundation

enum UserDefaultKey {
    static let isOnboardingFinished = "isOnboardingFinished"
    static let startDate = "startDate"
    static let skinType = "skinType"
    static let skinConcerns = "skinConcerns"
    static let skinGoal = "skinGoal"
}


class UserDefaultManager {
    static let shared = UserDefaultManager()
    private let defaults = UserDefaults.standard
    
    var isOnboardingFinished: Bool {
        get {
            defaults.bool(forKey: UserDefaultKey.isOnboardingFinished)
        } set {
            defaults.set(newValue, forKey: UserDefaultKey.isOnboardingFinished)
        }
    }
    
    var startDate: Date {
        get {
            return UserDefaults.standard.date(forKey: UserDefaultKey.startDate)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKey.startDate)
        }
    }
    
    var skinType: SkinType {
        get {
            let rawValue = defaults.string(forKey: UserDefaultKey.skinType) ?? SkinType.dry.rawValue
            return SkinType(rawValue: rawValue) ?? .dry
        }
        set {
            defaults.set(newValue.rawValue, forKey: UserDefaultKey.skinType)
        }
    }
    
    // MARK: - Goal Array
    var skinConcerns: [SkinConcern] {
        get {
            let rawValues = defaults.array(forKey: UserDefaultKey.skinConcerns) as? [String] ?? []
            let skinConcerns = rawValues.compactMap { SkinConcern(rawValue: $0) }
            return !skinConcerns.isEmpty ? skinConcerns : [SkinConcern.acne]
        }
        set {
            let rawValues = newValue.map { $0.rawValue }
            defaults.set(rawValues, forKey: UserDefaultKey.skinConcerns)
        }
    }
 
    var skinGoal: SkinGoal {
        get {
            let rawValue = defaults.string(forKey: UserDefaultKey.skinGoal) ?? SkinGoal.glowingSkin.rawValue
            return SkinGoal(rawValue: rawValue) ?? .glowingSkin
        }
        set {
            defaults.set(newValue.rawValue, forKey: UserDefaultKey.skinType)
        }
    }
}

extension UserDefaults {
    
    // MARK: - Date Storage Methods
    
    /// Save a date to UserDefaults
    func set(_ date: Date?, forKey key: String) {
        if let date = date {
            self.set(date.timeIntervalSince1970, forKey: key)
        } else {
            self.removeObject(forKey: key)
        }
    }
    
    /// Retrieve a date from UserDefaults
    func date(forKey key: String) -> Date {
        let timeInterval = self.double(forKey: key)
        return timeInterval > 0 ? Date(timeIntervalSince1970: timeInterval) : Date()
    }
}
