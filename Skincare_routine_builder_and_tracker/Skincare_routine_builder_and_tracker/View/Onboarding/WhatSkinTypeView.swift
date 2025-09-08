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
    }
    
    private var headerSection: some View {
        VStack(alignment: .center, spacing: 0) {
            SCProgressBarView(progress: 0.1, step: "1/5")
        }
    }
    
    private var skinTypeSection: some View {
        VStack(alignment: .center, spacing: 17) {
            
            SCText(title: "What's your skin type?", color: .scBlack, font: .system(size: 26, weight: .semibold))
                .padding(.top, 50)
                .padding(.bottom, 50)
            
            
            ForEach(SkinType.allCases, id: \.self) { type in
                let textColor = skinType != type ? .scBlack : Color.scPurple
                let borderColor: Color = skinType != type ? .scBorderGray : Color.scPurple
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center, spacing: 20) {
                        Image(type.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        
                        VStack(alignment: .leading, spacing: 2)  {
                            SCText(
                                title: type.title,
                                color: Color.scBlack, 
                                font: .system(size: 16, weight: .semibold, design: .rounded),
                                alignment: .leading
                            )
                            
                            SCText(
                                title: type.description,
                                color: Color(hex: "424242"),
                                font: .system(size: 13, weight: .regular, design: .rounded),
                                alignment: .leading
                            )
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 72)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(borderColor, lineWidth: 1) // <-- Rounded border
                )
                .padding(.horizontal, 20)
                .onTapGesture {
                    skinType = type
                }
            }
            
            Spacer()
        }
    }
    
    private var footerSection: some View {
        VStack(alignment: .center, spacing: 0) {
            
            SCButton(title: "Continue") {
                
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    WhatSkinTypeView()
}
