//
//  HomeTabView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

struct HomeTabView: View {
    
    @StateObject var tabRouter = TabRouter.shared
    @EnvironmentObject var navigationManager: NavigationManager
    
    let homeViewModel: HomeViewModel
    
    var body: some View {
        TabView(selection: $tabRouter.selectedTab) {
            
            NavigationStack(path: $navigationManager.path) {
                HomeView(viewModel: homeViewModel)
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        NavigationRouter.destinationView(destination: destination)
                    }
            }
            .tag(0)
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack(path: $navigationManager.path) {
                AnalysisView()
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        NavigationRouter.destinationView(destination: destination)
                    }
            }
            .tag(1)
            .tabItem {
                Label("Analysis", systemImage: "chart.xyaxis.line")
            }
            
            NavigationStack(path: $navigationManager.path) {
                ProfileView()
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        NavigationRouter.destinationView(destination: destination)
                    }
            }
            .tag(2)
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
        .tint(.scPurple)
    }
}
