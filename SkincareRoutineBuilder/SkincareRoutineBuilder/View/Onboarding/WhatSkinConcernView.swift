//
//  WhatSkinConcernView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

struct WhatSkinConcernView: View {
    @State var skinConcerns: [SkinConcern] = UserDefaultManager.shared.skinConcerns
    
    var body: some View {
        ZStack {
            SCGredientBG()
            
            VStack(alignment: .center, spacing: 0) {
                headerSection
                skinTypeSection
                footerSection
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SCProgressBarView(progress: 0.666, step: "2/3")
            
            SCBorderButton {
                NavigationManager.shared.pop()
            }
            .padding(.leading, 20)
        }
    }
    
    private var skinTypeSection: some View {
        VStack(alignment: .center, spacing: 0) {
            
            
            VStack(alignment: .leading, spacing: 0) {
                SCText(title: "What are your skin concerns?", color: .scBlack, font: .system(size: 26, weight: .semibold), alignment: .leading)
                    .padding(.top, 50)
                    .padding(.bottom, 5)

                SCText(title: "Select one or more areas you’d like to improve.", color: .scBlack, font: .system(size: 14, weight: .regular), alignment: .leading)
            }
            .padding(.bottom, 50)
            
            VStack(alignment: .center, spacing: 17) {
                let arrSkinConcerns = SkinConcern.allCases

                ForEach(0..<arrSkinConcerns.count / 2, id: \.self) { rowIndex in
                    HStack(spacing: 17) {
                        ForEach(0..<2, id: \.self) { columnIndex in
                            let index = rowIndex * 2 + columnIndex
                            if index < arrSkinConcerns.count {
                                
                                let concern = arrSkinConcerns[index]
                                let borderColor = !skinConcerns.contains(concern) ? Color.scBorderGray : Color.scPurple
                                
                                VStack(alignment: .center, spacing: 0) {
                                    VStack(alignment: .center, spacing: 10) {
                                        Image(concern.icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 35, height: 35)
                                    
                                        SCText(
                                            title: concern.title,
                                            color: Color.scBlack,
                                            font: .system(size: 16, weight: .semibold, design: .default),
                                            alignment: .leading
                                        )
                                    }
                                }
                                .frame(width: 140, height: 100)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(borderColor, lineWidth: 1)
                                )
                                .onTapGesture {
                                    if let index = skinConcerns.firstIndex(of: concern) {
                                        skinConcerns.remove(at: index)
                                    } else {
                                        skinConcerns.append(concern)
                                    }
                                    
                                    UserDefaultManager.shared.skinConcerns = skinConcerns
                                }
                            }
                        }
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
                NavigationManager.shared.push(to: .whatGoalView)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 15)
        }
    }
}

#Preview {
    NavigationStack {
        WhatSkinConcernView()
    }
}
