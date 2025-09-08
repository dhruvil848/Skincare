//
//  OnboardingEnums.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import Foundation

enum SkinType: String, CaseIterable, Identifiable {
    
    var title: String {
        switch self {
        case .dry:
            return "Dry"
        case .oily:
            return "Oily"
        case .combination:
            return "Combination"
        case .normal:
            return "Normal"
        }
    }
    
    var description: String {
        switch self {
        case .dry:
            return "Tight, rough, or flaky"
        case .oily:
            return "Shiny, greasy, large pores"
        case .combination:
            return "Mix of oily and dry areas"
        case .normal:
            return "Balanced, not too dry or oily"
        }
    }
    
    var icon: String {
        switch self {
        case .dry:
            return "ic_dry_skin"
        case .oily:
            return "ic_oily_skin"
        case .normal:
            return "ic_normal_skin"
        case .combination:
            return "ic_combination_skin"
        }
    }
    
    
    case dry = "Dry"
    case oily = "Oily"
    case normal = "Normal"
    case combination = "Combination"
    
    var id: String { return rawValue }
}

enum SkinConcern: String, CaseIterable, Identifiable {
    
    var title: String {
        switch self {
        case .acne:
            return "ic_acne"
        case .scar:
            return "ic_scars"
        case .pigmentation:
            return "ic_pigmentation"
        case .aging:
            return "ic_aging"
        }
    }
    
    
    var icon: String {
        switch self {
        case .acne:
            return "Dry"
        case .scar:
            return "Oily"
        case .pigmentation:
            return "Combination"
        case .aging:
            return "Normal"
        }
    }
    
    
    case acne = "Dry"
    case scar = "Oily"
    case pigmentation = "Normal"
    case aging = "Combination"
    
    var id: String { return rawValue }
}

enum SkinGoal: String, CaseIterable, Identifiable {
    
    var title: String {
        switch self {
        case .glowingSkin:
            return "Glowing skin"
        case .acneFree:
            return "Acne-Free"
        case .hydration:
            return "Hydration"
        case .antiAging:
            return "Anti-Aging"
        }
    }
    
    
    var description: String {
        switch self {
        case .glowingSkin:
            return "Radiant, healthy-looking skin"
        case .acneFree:
            return "Clear, blemish-free complexion"
        case .hydration:
            return "Well-moisturized, plump skin"
        case .antiAging:
            return "Reduce signs of aging"
        }
    }
    
    var icon: String {
        switch self {
        case .glowingSkin:
            return "ic_acne"
        case .acneFree:
            return "ic_scars"
        case .hydration:
            return "ic_pigmentation"
        case .antiAging:
            return "ic_aging"
        }
    }
    
    
    case glowingSkin = "Glowing skin"
    case acneFree = "Acne-Free"
    case hydration = "Hydration"
    case antiAging = "Anti-Aging"
    
    var id: String { return rawValue }
}
