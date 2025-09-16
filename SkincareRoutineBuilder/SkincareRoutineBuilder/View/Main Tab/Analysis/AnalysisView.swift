//
//  AnalysisView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

struct AnalysisView: View {
    @StateObject var viewModel = AnalysisViewModel()
    
    var body: some View {
        ZStack {
            SCGredientBG()
            
            VStack(alignment: .leading, spacing: 0) {
                headerSection
                tabSection
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SCText(title: "Your Progress 🎯", color: .scBlack, font: .system(size: 20, weight: .bold, design: .rounded), alignment: .leading)
                .padding(.bottom, 15)
            
            SCText(title: "Streak: \(viewModel.scTemplateDay?.streak ?? 0)", color: .init(hex: "3D3D3D"), font: .system(size: 16, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.2)
                .padding(.bottom, 5)
            
            
            SCText(title: "Let's track your skincare journey!!", color: .init(hex: "3D3D3D"), font: .system(size: 16, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.2)
            
        }
        .padding(.horizontal, paddingHorizontal)
        .padding(.top, 15)
    }
    
    private var tabSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            TabView(selection: $viewModel.selectedTab) {
                SCCalendarView()
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 30)
    }
}

#Preview {
    AnalysisView()
}
