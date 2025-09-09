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
    case combination = "Combination"
    case normal = "Normal"

    var id: String { return rawValue }
}

enum SkinConcern: String, CaseIterable, Identifiable {
    
    var title: String {
        switch self {
        case .acne:
            return "Acne"
        case .scar:
            return "Scars"
        case .pigmentation:
            return "Pigmentation"
        case .aging:
            return "Aging"
        }
    }
    
    
    var icon: String {
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
    
    
    case acne = "Acne"
    case scar = "Scars"
    case pigmentation = "Pigmentation"
    case aging = "Aging"
    
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
            return "ic_glowing_skin"
        case .acneFree:
            return "ic_acne_free"
        case .hydration:
            return "ic_hydration"
        case .antiAging:
            return "ic_normal_skin"
        }
    }
    
    
    case glowingSkin = "Glowing skin"
    case acneFree = "Acne-Free"
    case hydration = "Hydration"
    case antiAging = "Anti-Aging"
    
    var id: String { return rawValue }
}
