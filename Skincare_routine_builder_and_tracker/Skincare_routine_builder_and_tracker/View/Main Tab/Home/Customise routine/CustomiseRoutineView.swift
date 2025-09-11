//
//  CustomiseRoutineView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 11/09/25.
//

import SwiftUI

struct CustomiseRoutineView: View {
    
    @StateObject var viewModel = CustomiseRoutineViewModel()
    
    var body: some View {
        ZStack {
            SCGredientBG()
            
            VStack(alignment: .leading, spacing: 0) {
                List {
                    headerSection
                        .padding(.top, 25)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    
                    SCText(title: "Your Base Routine", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading, kerning: -0.01)
                        .padding(.top, 10)
                        .padding(.bottom, 25)
                        .padding(.horizontal, paddingHorizontal)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    
                    if let routines = viewModel.scTemplateDay?.routines?.array as? [SCTemplateRoutine] {
                        ForEach(routines.indices, id: \.self) { index in
                            routineCards(routine: routines[index])
                                .listRowInsets(EdgeInsets(top: 0,
                                                          leading: paddingHorizontal,
                                                          bottom: 25, // spacing between rows
                                                          trailing: paddingHorizontal))
                                .listRowSeparator(.hidden)
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: 0)
                                        .fill(Color.white)
                                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 0)
                                )
                                .padding(.horizontal, 20)
                            
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 25)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                    }
                  
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .frame(maxWidth: .infinity)
                
                footerSection
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                SCNavTitle(title: "Customise routine")
            }
            
            ToolbarItem(placement: .topBarLeading) {
                SCNavBackButton {
                    viewModel.btnBackAction()
                }
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var customiseRoutineSection: some View {
        VStack(alignment: .leading, spacing: 25) {
            headerSection
            baseRoutineSection
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SCText(title: "🧑🏻 Your Skin type: \(UserDefaultManager.shared.skinType.title)", color: .init(hex: "3D3D3D"), font: .system(size: 16, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.2)
                .padding(.bottom, 5)

            
            SCText(title: "🔴 Your concern: \(UserDefaultManager.shared.skinConcerns.compactMap({ $0.title }).joined(separator: ", "))", color: .init(hex: "3D3D3D"), font: .system(size: 16, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.2)
        }
        .padding(.horizontal, paddingHorizontal)
        .padding(.top, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private var baseRoutineSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SCText(title: "Your Base Routine", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading, kerning: -0.01)
                .padding(.top, 10)
            
            
            if let routines = viewModel.scTemplateDay?.routines?.array as? [SCTemplateRoutine] {
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
    
    @ViewBuilder
    private var footerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SCButton(title: "Save routine") {
                viewModel.btnSaveAction()
            }
        }
        .padding(.bottom, 15)
        .padding(.horizontal, paddingHorizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension CustomiseRoutineView {
    
    @ViewBuilder
    private func routineCards(routine: SCTemplateRoutine) -> some View {
        let routineSteps = routine.steps?.array as? [SCTemplateRoutineStep] ?? []
        
        
        /// Title section
        HStack(alignment: .center, spacing: 0) {
            SCText(title: routine.name ?? "-", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading)
            
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.scPurple)
                    .frame(width: 35, height: 35)
                    .background(Color.white)
            }
        }
        .background(Color.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        /// Routine step section
        ForEach(0..<routineSteps.count, id: \.self) { index in
            let step = routineSteps[index]
            
            routineStepRow(step: step) {
                
            }
        }
        .onDelete { _ in
            
        }
        .onMove { _, _ in
            
        }
    }
    
    
    @ViewBuilder
    private func routineStepRow(step: SCTemplateRoutineStep, onSelect: @escaping (() -> Void)) -> some View {
        let textColor: Color = step.isCompleted ? Color.gray : Color.scBlack
        
        VStack(alignment: .leading, spacing: 0) {
            Button {
                onSelect()
            } label: {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.scPurple)
                        .frame(width: 18, height: 18)
                        .offset(y: -2)

                    SCText(title: step.productName ?? "-", color: textColor, font: .system(size: 16.5, weight: .regular, design: .rounded), alignment: .leading, italic: step.isCompleted)
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        print("Delete")
                    } label: {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(Color.red)
                            .frame(width: 18, height: 18)
                            .offset(y: -2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color.white)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    
//    @ViewBuilder
//    private func routineCards(routine: SCTemplateRoutine) -> some View {
//        let routineSteps = routine.steps?.array as? [SCTemplateRoutineStep] ?? []
//        
//        VStack(alignment: .leading, spacing: 0) {
//            VStack(alignment: .leading, spacing: 20) {
//                
//                /// Title section
//                HStack(alignment: .center, spacing: 0) {
//                    SCText(title: routine.name ?? "-", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading)
//                        
//                    
//                    Spacer()
//                    
//                    Button {
//                        
//                    } label: {
//                        Image(systemName: "plus")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 15, height: 15)
//                            .foregroundColor(.scPurple)
//                            .frame(width: 35, height: 35)
//                            .background(Color.white)
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                
//                /// Routine step section
//                VStack(alignment: .leading, spacing: 13) {
//                    ForEach(0..<routineSteps.count, id: \.self) { index in
//                        let step = routineSteps[index]
//                        
//                        routineStepRow(step: step) {
//                            
//                        }
//                    }
//                    .onDelete { _ in
//                        
//                    }
//                    .onMove { _, _ in
//                        
//                    }
//                }
//                .padding(.horizontal, 2)
//            }
//            .padding(20)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(sectionBackgroundColor)
//        .cornerRadius(sectionCornerRadius)
//        .overlay(
//            RoundedRectangle(cornerRadius: sectionCornerRadius)
//                .stroke(sectionBorderColor, lineWidth: 1)
//        )
//        .frame(maxWidth: .infinity)
//    }
//    
//    
//    @ViewBuilder
//    private func routineStepRow(step: SCTemplateRoutineStep, onSelect: @escaping (() -> Void)) -> some View {
//        let textColor: Color = step.isCompleted ? Color.gray : Color.scBlack
//        
//        VStack(alignment: .leading, spacing: 0) {
//            Button {
//                onSelect()
//            } label: {
//                HStack(alignment: .center, spacing: 10) {
//                    Image(systemName: "square.and.pencil")
//                        .resizable()
//                        .scaledToFit()
//                        .foregroundStyle(Color.scPurple)
//                        .frame(width: 18, height: 18)
//                        .offset(y: -2)
//
//                    SCText(title: step.productName ?? "-", color: textColor, font: .system(size: 16.5, weight: .regular, design: .rounded), alignment: .leading, italic: step.isCompleted)
//                    
//                    Spacer(minLength: 0)
//                    
//                    Button {
//                        print("Delete")
//                    } label: {
//                        Image(systemName: "trash")
//                            .resizable()
//                            .scaledToFit()
//                            .foregroundStyle(Color.red)
//                            .frame(width: 18, height: 18)
//                            .offset(y: -2)
//                    }
//                }
//                .background(Color.white)
//                .frame(maxWidth: .infinity, alignment: .leading)
//            }
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//    }
}
