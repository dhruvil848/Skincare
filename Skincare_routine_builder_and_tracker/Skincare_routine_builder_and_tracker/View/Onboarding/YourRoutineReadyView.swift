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
                
                
                SCText(title: "🧴 Skin Type: \(UserDefaultManager.shared.skinType.title)", color: .scBlack, font: .system(size: 16, weight: .regular, design: .rounded), alignment: .leading)
                
                SCText(title: "🌿 Concerns: \(UserDefaultManager.shared.skinConcerns.compactMap({ $0.title }).joined(separator: ", "))", color: .scBlack, font: .system(size: 16, weight: .regular, design: .rounded), alignment: .leading)
                
                SCText(title: "⏳ Goal: \(UserDefaultManager.shared.skinGoal.title)", color: .scBlack, font: .system(size: 16, weight: .regular, design: .rounded), alignment: .leading)
            }
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
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
                NavigationManager.shared.push(to: .yourRoutineReadyView)
            }
            .padding(.bottom, 15)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    YourRoutineReadyView()
}
