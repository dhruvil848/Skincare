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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SCText(title: "Progress Analysis", color: .scBlack, font: .system(size: 20, weight: .bold, design: .rounded), alignment: .leading)
                .padding(.bottom, 10)
            
            SCText(title: "Review your routines and progress!!", color: .init(hex: "3D3D3D"), font: .system(size: 16, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.2)
        }
        .padding(.horizontal, paddingHorizontal)
        .padding(.top, 15)
    }
    
    private var headerOptionSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 20) {
                headerOption(title: "Calendar", isSelected: viewModel.selectedTab == 0) {
                    viewModel.selectTab(at: 0)
                }
                
                headerOption(title: "Stats", isSelected: viewModel.selectedTab == 1) {
                    viewModel.selectTab(at: 1)
                }
                
                headerOption(title: "Journal", isSelected: viewModel.selectedTab == 2) {
                    viewModel.selectTab(at: 2)
                }
            }
            .padding(5)
        }
        .frame(maxWidth: .infinity)
        .background(sectionBackgroundColor)
        .cornerRadius(sectionCornerRadius)
        .overlay(
            Capsule()
                .stroke(sectionBorderColor, lineWidth: 1)
        )
        .padding(.horizontal, paddingHorizontal)
        .frame(maxWidth: .infinity)
    }
    
    private func headerOption(title: String, isSelected: Bool, onSelect: @escaping (() -> Void)) -> some View {
        VStack(alignment: .center, spacing: 0) {
            SCText(title: title, color: isSelected ? .white : .scBlack, font: .system(size: 13, weight: .medium, design: .rounded), alignment: .center)
        }
        .frame(height: 31)
        .frame(maxWidth: .infinity, alignment: .center)
        .background {
            Capsule()
                .fill(isSelected ? Color.scPurple : Color.clear)
        }
        .onTapGesture {
            onSelect()
        }
    }
    
    private var tabSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            headerOptionSection
               
            
            TabView(selection: $viewModel.selectedTab) {
                calendarSection
                    .tag(0)
            }
            .tabViewStyle(PageTabViewStyle())
        }
        .frame(alignment: .top)
        .padding(.top, 25)
    }
    
    private var calendarSection: some View {
        VStack(alignment: .center, spacing: 0) {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 0) {
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
                    .padding(.vertical, 25)
                    
                    
                    if let routines = viewModel.selectedDay?.routines?.array as? [SCRoutine] {
                        SCText(title: "Selected date routine", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading, kerning: -0.01)
                            .padding(.horizontal, paddingHorizontal)
                            .padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(0..<routines.count, id: \.self) { index in
                                routineCards(routine: routines[index])
                                
                                if routines.count-1 != index {
                                    Divider()
                                        .padding(.horizontal, 20)
                                }
                            }
                        }
                        .disabled(!viewModel.isSelectedDateToday)
                        .frame(maxWidth: .infinity)
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
                    
                    SCText(title: routine.name ?? "-", color: viewModel.isSelectedDateToday ? .scBlack : .gray, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading)
                            
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 0) {
                        SCText(title: "\(completedPecentage)% complete", color: viewModel.isSelectedDateToday ? .scPurple : .gray, font: .system(size: 14, weight: .regular, design: .rounded), alignment: .center)
                            .padding(.horizontal, 13)
                    }
                    .frame(height: 28)
                    .background(viewModel.isSelectedDateToday ? Color.init(hex: "FFF6F9") : Color.gray.opacity(0.2))
                    .cornerRadius(28/2)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if routineSteps.isEmpty {
                    SCText(title: "This routine has no steps.", color: .scBlack, font: .system(size: 14, weight: .regular, design: .rounded), alignment: .leading)
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
    }
    
    
    @ViewBuilder
    private func routineStepRow(step: SCRoutineStep, onSelect: @escaping (() -> Void)) -> some View {
        let textColor: Color = viewModel.isSelectedDateToday ? step.isCompleted ? Color.gray : Color.scBlack : .gray
        let imageName: String = step.isCompleted ? viewModel.isSelectedDateToday ? "ic_check_square" : "ic_check_square_gray" : "ic_uncheck_square"
        
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
