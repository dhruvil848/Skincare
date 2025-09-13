//
//  HomeView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

let paddingHorizontal: CGFloat = 25
let sectionBackgroundColor = Color.white
let sectionBorderColor = Color.scBorderGray
let sectionCornerRadius: CGFloat = 15

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white // default color

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            SCGredientBG()
            
            VStack(alignment: .leading, spacing: 0) {
                homeSection
                    .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            viewModel.initialize()
        }
        .overlay {
            
        }
    }
    
    @ViewBuilder
    private var homeSection: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                headerSection
                streakSection
                todayRoutineSection
                dailyTipSection
            }
            .frame(maxWidth: .infinity)
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SCText(title: "Hi, \(Utility.greetingMessage())", color: .scBlack, font: .system(size: 20, weight: .bold, design: .rounded), alignment: .leading)
                .padding(.bottom, 15)
            
            SCText(title: "Your concern: \(UserDefaultManager.shared.skinConcerns.compactMap({ $0.title }).joined(separator: ", "))", color: .init(hex: "3D3D3D"), font: .system(size: 16, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.2)
                .padding(.bottom, 5)
            
            SCText(title: "Let’s care of your skin today!! 🚀 ", color: .init(hex: "3D3D3D"), font: .system(size: 16, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.2)
        }
        .padding(.horizontal, paddingHorizontal)
        .padding(.top, 15)
    }
    
    @ViewBuilder
    private var streakSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                SCText(title: "🔥 Streak", color: .scBlack, font: .system(size: 18, weight: .medium, design: .rounded), alignment: .leading)
                
                let textColor = viewModel.scDay?.isCompleted == true ? Color.scPurple : Color.gray
                HStack(alignment: .center, spacing: 15) {
                    SCText(title: "\(viewModel.scTemplateDay?.streak ?? 0) Days", color: textColor, font: .system(size: 20, weight: .bold, design: .default), alignment: .leading)
                    
                    
                    let totalDays = 7  // always a week
                    let progress = Float(CoreDataManager.shared.getCompletedDaysThisWeek()) / Float(totalDays)
                    SCStreakProgressBarView(color: textColor, progress: progress)
                        .animation(.easeInOut, value: viewModel.scTemplateDay?.streak)
                }
                
                SCText(title: Utility.streakMessage(streak: viewModel.scTemplateDay?.streak), color: .init(hex: "707070"), font: .system(size: 14, weight: .regular, design: .default), alignment: .leading)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 17)
        }
        .background(sectionBackgroundColor)
        .cornerRadius(sectionCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: sectionCornerRadius)
                .stroke(sectionBorderColor, lineWidth: 1) // border color and width
        )
        .padding(.horizontal, paddingHorizontal)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var todayRoutineSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SCText(title: "Today's Routine", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading, kerning: -0.01)
            
            
            if let routines = viewModel.scDay?.routines?.array as? [SCRoutine] {
                VStack(alignment: .leading, spacing: 25) {
                    ForEach(0..<routines.count, id: \.self) { index in
                        routineCards(routine: routines[index])
                    }
                }
            }
            
        }
        .padding(.horizontal, paddingHorizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var dailyTipSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                SCText(title: "🌸️  Daily Tip", color: .scBlack, font: .system(size: 18, weight: .medium, design: .rounded), alignment: .leading, kerning: 0)
                
                SCText(title: Utility.getDailyTip(), color: .init(hex: "333333"), font: .system(size: 16, weight: .regular, design: .rounded), alignment: .leading, kerning: 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 17)
        }
        .background(sectionBackgroundColor)
        .cornerRadius(sectionCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: sectionCornerRadius)
                .stroke(sectionBorderColor, lineWidth: 1)
        )
        .padding(.horizontal, paddingHorizontal)
        .frame(maxWidth: .infinity)
    }
    
}

extension HomeView {
    @ViewBuilder
    private func routineCards(routine: SCRoutine) -> some View {
        let routineSteps = routine.steps?.array as? [SCRoutineStep] ?? []
        let completedPecentage = Int(CoreDataManager.shared.routineCompletionPercentage(for: routine))
        
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 20) {
                
                /// Title section
                HStack(alignment: .center, spacing: 0) {
                    Button {
                        viewModel.btnCustomiseRoutineAction()
                    } label: {
                        HStack(alignment: .center, spacing: 10) {
                            SCText(title: routine.name ?? "-", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading)
                            
                            Image("ic_edit")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                    }
                    
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
                                viewModel.btnSelectRoutine(routine: routine, step: step)
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
