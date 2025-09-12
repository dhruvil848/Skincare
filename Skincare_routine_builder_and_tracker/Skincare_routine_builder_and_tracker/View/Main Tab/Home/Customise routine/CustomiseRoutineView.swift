////
////  CustomiseRoutineView.swift
////  Skincare_routine_builder_and_tracker
////
////  Created by Dhruvil Moradiya on 11/09/25.
////

import SwiftUI

struct CustomiseRoutineView: View {
    
    @StateObject var viewModel = CustomiseRoutineViewModel()
    
    var body: some View {
        ZStack {
            SCGredientBG()
            
            VStack(alignment: .leading, spacing: 0) {
                List {
                    headerSection
                        .padding(.top, 10)
                        .padding(.bottom, 25)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    
                    SCText(title: "Your Base Routine", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading, kerning: -0.01)
                        .padding(.bottom, 25)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    
                    
                    if let routines = viewModel.scDay?.routines?.array as? [SCTemplateRoutine] {
                        ForEach(routines.indices, id: \.self) { index in
                            
                            routineCards(routine: routines[index])
                                .padding(.horizontal, 1)
                                .frame(maxWidth: .infinity)
                                .listRowSpacing(0)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .shadow(radius: 0.6)

                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 0)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                    }
                  
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .environment(\.defaultMinListRowHeight, 0)
                .environment(\.defaultMinListHeaderHeight, 0)
                .padding(.horizontal, paddingHorizontal)
            }
        }
        .id(viewModel.refreshId)
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
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button("OK") {
                viewModel.showAlert = false
            }

        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SCText(title: "You can press and drag to reorder steps and swipe to delete a step in the routine.", color: .init(hex: "3D3D3D"), font: .system(size: 16, weight: .regular, design: .rounded), alignment: .leading, kerning: -0.2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension CustomiseRoutineView {
    
    @ViewBuilder
    private func routineCards(routine: SCTemplateRoutine) -> some View {
        let routineSteps = routine.steps?.array as? [SCTemplateRoutineStep] ?? []
        
        Section {
            
            /// Title section
            HStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    SCText(title: routine.name ?? "-", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading)
                    
                    
                    Spacer()
                    
                    Button {
                        viewModel.btnAddProductAction(routine: routine)
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.scPurple)
                            .frame(width: 35, height: 35)
                            .background(Color.white)
                    }
                    .background(Color.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(.white)
            .cornerRadius(sectionCornerRadius, corners: [.topLeft, .topRight])
            
            /// Routine step section
            ForEach(0..<routineSteps.count, id: \.self) { index in
                let step = routineSteps[index]
                let isLast = index+1 == routineSteps.count
                
                routineStepRow(routine: routine, step: step, isLast: isLast) {
                    viewModel.openAddProductView(isForEdit: true, routine: routine, routineStep: step)
                }
            }
            .onMove { indexSet, index in
                viewModel.moveStep(in: routine, from: indexSet, to: index)
            }
            .onDelete { indexSet in
                viewModel.deleteStep(from: routine, indexSet: indexSet)
            }
            .backgroundStyle(Color.white)
        }
        .background(Color.clear)
    }
    
    @ViewBuilder
    private func routineStepRow(routine: SCTemplateRoutine, step: SCTemplateRoutineStep, isLast: Bool, onSelect: @escaping (() -> Void)) -> some View {
        
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
                    
                    SCText(title: step.product?.name ?? "-", color: Color.scBlack, font: .system(size: 16.5, weight: .regular, design: .rounded), alignment: .leading, italic: false)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "line.3.horizontal")
                        .foregroundStyle(Color.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 15)
        }
        .padding(.horizontal, 24)
        .background(Color.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .if(isLast) { view in
            view.cornerRadius(sectionCornerRadius, corners: [.bottomLeft, .bottomRight])
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCornerShape(radius: radius, corners: corners))
    }
}

// MARK: - Custom Shape
struct RoundedCornerShape: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
