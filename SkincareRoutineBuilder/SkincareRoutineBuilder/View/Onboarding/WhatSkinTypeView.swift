//
//  WhatSkinTypeView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import SwiftUI

struct WhatSkinTypeView: View {
    @AppStorage(UserDefaultKey.skinType) var skinType: SkinType = UserDefaultManager.shared.skinType
    
    var body: some View {
        ZStack {
            SCGredientBG()
            
            VStack(alignment: .center, spacing: 0) {
                headerSection
                skinTypeSection
                footerSection
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden()
    }
    
    private var headerSection: some View {
        VStack(alignment: .center, spacing: 0) {
            SCProgressBarView(progress: 0.333, step: "1/3")
        }
    }
    
    private var skinTypeSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            SCText(title: "What's your skin type?", color: .scBlack, font: .system(size: 26, weight: .semibold), alignment: .leading)
                .padding(.top, 50)
                .padding(.bottom, 5)
            
            SCText(title: "This helps us personalize your skincare routine for your needs.", color: .scBlack, font: .system(size: 14, weight: .regular), alignment: .leading)
                .padding(.bottom, 50)
            
            
            VStack(alignment: .center, spacing: 17) {
                ForEach(SkinType.allCases, id: \.self) { type in
                    let borderColor: Color = skinType != type ? .scBorderGray : Color.scPurple
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .center, spacing: 20) {
                            Image(type.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            VStack(alignment: .leading, spacing: 5)  {
                                SCText(
                                    title: type.title,
                                    color: Color.scBlack,
                                    font: .system(size: 16, weight: .semibold, design: .default),
                                    alignment: .leading
                                )
                                
                                
                                SCText(
                                    title: type.description,
                                    color: Color(hex: "424242"),
                                    font: .system(size: 13, weight: .regular, design: .default),
                                    alignment: .leading
                                )
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor, lineWidth: 1)
                    )
                    .onTapGesture {
                        skinType = type
                    }
                }
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
    }
    
    private var footerSection: some View {
        VStack(alignment: .center, spacing: 0) {
            
            SCButton(title: "Continue") {
                NavigationManager.shared.push(to: .whatSkinConcernView)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 15)
        }
    }
}

#Preview {
    NavigationStack {
        WhatSkinTypeView()
    }
}
