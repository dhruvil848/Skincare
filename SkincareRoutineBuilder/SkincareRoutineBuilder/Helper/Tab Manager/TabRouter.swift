//
//  TabRouter.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

class TabRouter: ObservableObject {
    
    @Published var selectedTab: Int = 0
    static let shared = TabRouter()
}
