//
//  YourRoutineReadyView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

struct YourRoutineReadyView: View {
    
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
            VStack(alignment: .leading, spacing: 10) {
                SCText(title: "Your routine is ready!", color: .scBlack, font: .system(size: 20, weight: .semibold, design: .default), alignment: .leading)
                    .padding(.bottom, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SCText(title: "🧴 Skin Type: \(UserDefaultManager.shared.skinType.title)", color: .scBlack, font: .system(size: 16, weight: .regular, design: .rounded), alignment: .leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SCText(title: "🌿 Concerns: \(UserDefaultManager.shared.skinConcerns.compactMap({ $0.title }).joined(separator: ", "))", color: .scBlack, font: .system(size: 16, weight: .regular, design: .rounded), alignment: .leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                                   
                SCText(title: "⏳ Goal: \(UserDefaultManager.shared.skinGoal.title)", color: .scBlack, font: .system(size: 16, weight: .regular, design: .rounded), alignment: .leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.scBorderGray, lineWidth: 1)
            )
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    private var skinTypeSection: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer(minLength: 0)
            Image("confetti")
                .resizable()
                .frame(width: 250, height: 191)
            
            Spacer(minLength: 0)
        }
    }
    
    private var footerSection: some View {
        VStack(alignment: .center, spacing: 22) {
            SCText(title: "Your personalized skincare journey starts today. Let’s glow!", color: .scBlack, font: .system(size: 15, weight: .regular, design: .rounded), alignment: .center)
           
            
            SCButton(title: "Start my journey") {
                moveToHomeScreen()
            }
            .padding(.bottom, 15)
        }
        .padding(.horizontal, 20)
    }
    
    
    func moveToHomeScreen() {
        CoreDataManager.shared.createBaseRoutineIfNeeded()
        UserDefaultManager.shared.startDate = Date()
        UserDefaultManager.shared.isOnboardingFinished = true
        AppState.shared.moveToHomeTab()
    }
}

#Preview {
    YourRoutineReadyView()
}
