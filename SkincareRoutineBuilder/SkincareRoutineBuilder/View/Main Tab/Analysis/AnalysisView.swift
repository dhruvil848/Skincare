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
        ZStack(alignment: .top) {
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
            
            SCText(title: "⭐ Track your skincare journey", color: .init(hex: "3D3D3D"), font: .system(size: 16, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.2)
        }
        .padding(.horizontal, paddingHorizontal)
        .padding(.top, 15)
    }
    
    private var tabSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            TabView(selection: $viewModel.selectedTab) {
                calendarSection
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .frame(alignment: .top)
        .padding(.top, 20)
    }
    
    private var calendarSection: some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 25) {
                    SCCalendarView(viewModel: viewModel)
                        .background(sectionBackgroundColor)
                        .cornerRadius(sectionCornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: sectionCornerRadius)
                                .stroke(sectionBorderColor, lineWidth: 1)
                        )
                        .padding(.horizontal, paddingHorizontal)
                        .padding(.top, 1)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        calendarInstructionRow(title: "Both routines completed", color: viewModel.bothRoutineCompletedColor)
                        calendarInstructionRow(title: "One routine completed", color: viewModel.oneRoutineCompletedColor)
                        calendarInstructionRow(title: "No routine completed", color: viewModel.noRoutineCompletedColor)
                    }
                    .padding(.horizontal, paddingHorizontal)
                    
                    
                    if let routines = viewModel.selectedDay?.routines?.array as? [SCRoutine] {
                        VStack(alignment: .leading, spacing: 25) {
                            ForEach(0..<routines.count, id: \.self) { index in
                                routineCards(routine: routines[index])
                            }
                        }
                        .padding(.horizontal, paddingHorizontal)
                    }
                }
                .padding(.bottom, 30)
            }
            .scrollIndicators(.hidden)
        }
    }
}

extension AnalysisView {
    
    @ViewBuilder
    func calendarInstructionRow(title: String, color: Color) -> some View {
        HStack(alignment: .center, spacing: 10) {
            Circle()
                .fill(color)
                .frame(width: 5, height: 5)
            
            SCText(title: title, color: .scBlack.opacity(0.8), font: .system(size: 14, weight: .regular, design: .default), alignment: .leading)
        }
    }
}

extension AnalysisView {
    @ViewBuilder
    private func routineCards(routine: SCRoutine) -> some View {
        let routineSteps = routine.steps?.array as? [SCRoutineStep] ?? []
        let completedPecentage = Int(CoreDataManager.shared.routineCompletionPercentage(for: routine))
        
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 20) {
                
                /// Title section
                HStack(alignment: .center, spacing: 0) {
                    
                    SCText(title: routine.name ?? "-", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading)
                            
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 0) {
                        SCText(title: "\(completedPecentage)% complete", color: .scPurple, font: .system(size: 14, weight: .regular, design: .rounded), alignment: .center)
                            .padding(.horizontal, 13)
                    }
                    .frame(height: 28)
                    .background(Color.init(hex: "FFF6F9"))
                    .cornerRadius(28/2)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if routineSteps.isEmpty {
                    SCText(title: "This routine has no steps to follow today.", color: .scBlack, font: .system(size: 14, weight: .regular, design: .rounded), alignment: .leading)
                        .padding(.top, 15)
                }
                
                /// Routine step section
                VStack(alignment: .leading, spacing: 13) {
                    ForEach(0..<routineSteps.count, id: \.self) { index in
                        let step = routineSteps[index]
                        
                        routineStepRow(
                            step: step,
                            onSelect: {
                                
                            }
                        )
                    }
                }
                .padding(.horizontal, 2)
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(sectionBackgroundColor)
        .cornerRadius(sectionCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: sectionCornerRadius)
                .stroke(sectionBorderColor, lineWidth: 1)
        )
        .frame(maxWidth: .infinity)
    }
    
    
    @ViewBuilder
    private func routineStepRow(step: SCRoutineStep, onSelect: @escaping (() -> Void)) -> some View {
        let textColor: Color = step.isCompleted ? Color.gray : Color.scBlack
        let imageName: String = step.isCompleted ? "ic_check_square"  : "ic_uncheck_square"
        
        VStack(alignment: .leading, spacing: 0) {
            Button {
                onSelect()
            } label: {
                HStack(alignment: .center, spacing: 12) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    
                    SCText(title: step.product?.name ?? "-", color: textColor, font: .system(size: 16.5, weight: .regular, design: .rounded), alignment: .leading, italic: step.isCompleted)
                }
                .background(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}




#Preview {
    AnalysisView()
}
