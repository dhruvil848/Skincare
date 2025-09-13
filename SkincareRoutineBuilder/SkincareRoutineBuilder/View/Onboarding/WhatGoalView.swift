//
//  WhatGoalView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

struct WhatGoalView: View {
    @AppStorage(UserDefaultKey.skinGoal) var skinGoal: SkinGoal = UserDefaultManager.shared.skinGoal
    
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
            SCProgressBarView(progress: 1, step: "3/3")
            
            SCBorderButton {
                NavigationManager.shared.pop()
            }
            .padding(.leading, 20)
        }
    }
    
    private var skinTypeSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            SCText(title: "What’s your main goal?", color: .scBlack, font: .system(size: 26, weight: .semibold), alignment: .leading)
                .padding(.top, 50)
                .padding(.bottom, 5)
            
            SCText(title: "Choose the result you want to focus on first.", color: .scBlack, font: .system(size: 14, weight: .regular), alignment: .leading)
                .padding(.bottom, 50)
            
            VStack(alignment: .center, spacing: 17) {
                ForEach(SkinGoal.allCases, id: \.self) { goal in
                    let borderColor: Color = skinGoal != goal ? .scBorderGray : Color.scPurple
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .center, spacing: 20) {
                            Image(goal.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                            
                            VStack(alignment: .leading, spacing: 5)  {
                                SCText(
                                    title: goal.title,
                                    color: Color.scBlack,
                                    font: .system(size: 16, weight: .semibold, design: .default),
                                    alignment: .leading
                                )
                                
                                
                                SCText(
                                    title: goal.description,
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
                        skinGoal = goal
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
                NavigationManager.shared.push(to: .yourRoutineReadyView)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 15)
        }
    }
}

#Preview {
    WhatGoalView()
}
