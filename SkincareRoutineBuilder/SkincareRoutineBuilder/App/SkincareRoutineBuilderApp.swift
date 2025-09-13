//
//  SkincareRoutineBuilderApp.swift
//  SkincareRoutineBuilder
//
//  Created by Dhruvil Moradiya on 13/09/25.
//

import SwiftUI

@main
struct SkincareRoutineBuilderApp: App {
    @StateObject var appState = AppState.shared
    @StateObject var navigationManager = NavigationManager.shared
        
    var body: some Scene {
        WindowGroup {
            rootView(flow: appState.flow)
                .environmentObject(navigationManager)
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
            HomeTabView(homeViewModel: appState.homeViewModel)
        case .none:
            VStack {}
        }
    }
}
