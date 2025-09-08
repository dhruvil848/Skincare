//
//  UserDefaultManager.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//


import Foundation

enum UserDefaultKey {
    static let isOnboardingFinished = "isOnboardingFinished"
    static let skinType = "skinType"
    static let skinConcern = "skinConcern"
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
    
    
    var skinType: SkinType {
        get {
            let rawValue = defaults.string(forKey: UserDefaultKey.skinType) ?? SkinType.dry.rawValue
            return SkinType(rawValue: rawValue) ?? .dry
        }
        set {
            defaults.set(newValue.rawValue, forKey: UserDefaultKey.skinType)
        }
    }
    
    var skinConcern: SkinConcern {
        get {
            let rawValue = defaults.string(forKey: UserDefaultKey.skinConcern) ?? SkinConcern.acne.rawValue
            return SkinConcern(rawValue: rawValue) ?? .acne
        }
        set {
            defaults.set(newValue.rawValue, forKey: UserDefaultKey.skinType)
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
