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
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                SCNavTitle(title: "Add product")
            }
            
            ToolbarItem(placement: .topBarLeading) {
                SCNavBackButton {
                    viewModel.btnBackAction()
                }
            }
        }
    }
    
    private var productDetailSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            productNameSection
            productTypeSection
        }
        .padding(.top, 10)
        .padding(.horizontal, paddingHorizontal)
    }
    
    private var productNameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionTitle(title: "Product name")
            
            HStack(alignment: .center, spacing: 0) {
                TextField("", text: $viewModel.productName)
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
    
    private var productTypeSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionTitle(title: "Product Type")
            
            HStack(alignment: .center, spacing: 0) {
                TextField("", text: $viewModel.productName)
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
            SCText(title: title, color: Color.scBlack, font: .system(size: 16, weight: .regular, design: .rounded), alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
