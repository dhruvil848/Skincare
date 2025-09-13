//
//  AddProductView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 11/09/25.
//

import SwiftUI

struct AddProductView: View {
    
    @ObservedObject var viewModel: AddProductViewModel
    
    var body: some View {
        ZStack {
            SCGredientBG()
            
            VStack(alignment: .leading, spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        productDetailSection
                    }
                    .frame(maxWidth: .infinity)
                }
                
                footerSection
                    .ignoresSafeArea(.keyboard)
            }
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                SCNavTitle(title: viewModel.isForEdit ? "Edit product" : "Add product")
            }
            
            ToolbarItem(placement: .topBarLeading) {
                SCNavBackButton {
                    viewModel.btnBackAction()
                }
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button("OK") {
                viewModel.showAlert = false
            }

        } message: {
            Text(viewModel.alertMessage)
        }
    }
    
    private var productDetailSection: some View {
        VStack(alignment: .leading, spacing: 25) {
            productNameSection
            productTypeSection
            timeOfDaySection
            frequencySection
        }
        .padding(.top, 10)
        .padding(.horizontal, paddingHorizontal)
    }
    
    private var productNameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionTitle(title: "Product name")
            
            HStack(alignment: .center, spacing: 0) {
                TextField("", text: $viewModel.productName)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .tint(Color.scPurple)
                    .padding(.horizontal, 10)
            }
            .frame(minHeight: 40)
            .background(sectionBackgroundColor)
            .cornerRadius(7)
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(sectionBorderColor, lineWidth: 1)
            )
            .frame(maxWidth: .infinity)
        }
    }
    
    private func sectionTitle(title: String) -> some View {
        HStack(alignment: .center, spacing: 0) {
            SCText(title: title, color: .scBlack, font: .system(size: 17, weight: .semibold, design: .rounded), alignment: .leading, kerning: -0.01)
                .frame(alignment: .leading)
        }
    }
    
    private var productTypeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle(title: "Product type")
            
            optionsList(arrOptions: viewModel.arrProductType, selectedOption: viewModel.productType) { productType in
                viewModel.productType = productType
            }
        }
    }
    
    private var timeOfDaySection: some View {
        VStack(alignment: .leading, spacing: 0) {
            sectionTitle(title: "Time of day")
                .padding(.bottom, viewModel.disableTimeOfDay ? 0 : 10)
            
            if viewModel.disableTimeOfDay {
                SCText(title: "Time of day cannot be changed because this is the only product in the routine.", color: .gray, font: .system(size: 14, weight: .regular, design: .rounded), alignment: .leading, lineSpacing: 0)
                    .padding(.top, 5)
                    .padding(.bottom, 15)
            }
            
            optionsList(arrOptions: viewModel.arrTime, selectedOption: viewModel.timeOfDay) { productType in
                viewModel.timeOfDay = productType
            }
            .disabled(viewModel.disableTimeOfDay)
            .opacity(viewModel.disableTimeOfDay ? 0.5 : 1)
        }
    }
    
    private var frequencySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionTitle(title: "Frequency")
            
            optionsList(arrOptions: viewModel.arrFrequency, selectedOption: viewModel.frequency) { productType in
                viewModel.frequency = productType
            }
        }
    }
    
    private var footerSection: some View {
        SCButton(title: viewModel.isForEdit ? "Save" : "Add to routine") {
            viewModel.btnSaveAction()
        }
        .padding(.horizontal, paddingHorizontal)
        .padding(.bottom, 15)
    }
}

extension AddProductView {
    @ViewBuilder
    private func optionsList(arrOptions: [String], selectedOption: String, onSelect: @escaping ((String) -> Void)) -> some View {
        FlowHStack(horizontalSpacing: 10, verticalSpacing: 10) {
            ForEach(arrOptions, id: \.self) { option in
                optionChip(
                    title: option,
                    selected: option == selectedOption,
                    onSelect: {
                        onSelect(option)
                    }
                )
            }
        }
    }
    
    private func optionChip(title: String, selected: Bool, onSelect: @escaping (() -> Void)) -> some View {
        Button(action: onSelect) {
            Text(title)
                .font(.system(size: 14, weight: selected ? .medium : .medium, design: .rounded))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    selected ? Color.scPurple.opacity(0.05) : Color.white
                )
                .foregroundColor(selected ? Color.scPurple : .init(hex: "757575"))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(selected ? Color.scPurple : Color.init(hex: "D2D2D2"), lineWidth: 1)
                )
                .kerning(-0.1)
                .cornerRadius(20)
        }
    }
}

struct FlowHStack: Layout {
    var horizontalSpacing: CGFloat = 8
    var verticalSpacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let subviewSizes = subviews.map { $0.sizeThatFits(proposal) }
        let maxSubviewHeight = subviewSizes.map { $0.height }.max() ?? .zero
        var currentRowWidth: CGFloat = .zero
        var totalHeight: CGFloat = maxSubviewHeight
        var totalWidth: CGFloat = .zero

        for size in subviewSizes {
            let requestedRowWidth = currentRowWidth + horizontalSpacing + size.width
            let availableRowWidth = proposal.width ?? .zero
            let willOverflow = requestedRowWidth > availableRowWidth

            if willOverflow {
                totalHeight += verticalSpacing + maxSubviewHeight
                currentRowWidth = size.width
            } else {
                currentRowWidth = requestedRowWidth
            }

            totalWidth = max(totalWidth, currentRowWidth)
        }

        return CGSize(width: totalWidth, height: totalHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let subviewSizes = subviews.map { $0.sizeThatFits(proposal) }
        let maxSubviewHeight = subviewSizes.map { $0.height }.max() ?? .zero
        var point = CGPoint(x: bounds.minX, y: bounds.minY)

        for index in subviews.indices {
            let requestedWidth = point.x + subviewSizes[index].width
            let availableWidth = bounds.maxX
            let willOverflow = requestedWidth > availableWidth

            if willOverflow {
                point.x = bounds.minX
                point.y += maxSubviewHeight + verticalSpacing
            }

            subviews[index].place(at: point, proposal: ProposedViewSize(subviewSizes[index]))
            point.x += subviewSizes[index].width + horizontalSpacing
        }
    }
}
