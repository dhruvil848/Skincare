//
//  Skincare_routine_builder_and_trackerApp.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import SwiftUI
import SwiftData

@main
struct Skincare_routine_builder_and_trackerApp: App {
    
    @StateObject var appState = AppState.shared
    @StateObject var navigationManager = NavigationManager.shared
        
    var body: some Scene {
        WindowGroup {
            rootView(flow: appState.flow)
        }
    }
    
    @ViewBuilder
    func rootView(flow: AppFlow) -> some View {
        switch flow {
        case .onBoarding:
            NavigationStack(path: $navigationManager.path) {
                WelcomeView()
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        NavigationRouter.destinationView(destination: destination)
                    }
            }
        case .home:
            VStack {}
        case .none:
            VStack {}
        }
    }
}
