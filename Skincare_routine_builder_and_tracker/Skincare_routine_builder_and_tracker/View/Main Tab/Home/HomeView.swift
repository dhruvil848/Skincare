//
//  HomeView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    let paddingHorizontal: CGFloat = 25
    let sectionBackgroundColor = Color.white
    let sectionBorderColor = Color.scBorderGray
    let sectionCornerRadius: CGFloat = 15
    
    var body: some View {
        ZStack {
            SCGredientBG()
            
            VStack(alignment: .leading, spacing: 0) {
                homeSection
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            viewModel.intialize()
        }
    }
    
    @ViewBuilder
    private var homeSection: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                headerSection
                streakSection
                todayRoutineSection
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SCText(title: "Hi, ready for your routine? 👋🏻", color: .scBlack, font: .system(size: 20, weight: .semibold, design: .rounded), alignment: .leading)
                .padding(.bottom, 15)
            
            SCText(title: "🔴  Your concern: \(UserDefaultManager.shared.skinConcerns.compactMap({ $0.title }).joined(separator: ", "))", color: .scBlack, font: .system(size: 14, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.1)
                .padding(.bottom, 6)
            
            SCText(title: "💁🏻‍♀️  Let’s care of your skin today!!", color: .scBlack, font: .system(size: 14, weight: .medium, design: .rounded), alignment: .leading, kerning: -0.1)
        }
        .padding(.horizontal, paddingHorizontal)
        .padding(.top, 15)
    }
    
    @ViewBuilder
    private var streakSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                SCText(title: "🔥 Streak", color: .scBlack, font: .system(size: 18, weight: .medium, design: .rounded), alignment: .leading)
                
                HStack(alignment: .center, spacing: 15) {
                    SCText(title: "7 Days", color: .scPurple, font: .system(size: 20, weight: .bold, design: .default), alignment: .leading)
                    
                    SCStreakProgressBarView(progress: 0.8)
                }
                
                SCText(title: "You are on the right track, keep it up.", color: .init(hex: "707070"), font: .system(size: 14, weight: .regular, design: .default), alignment: .leading)
            }
            .padding(20)
        }
        .background(sectionBackgroundColor)
        .cornerRadius(sectionCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: sectionCornerRadius)
                .stroke(sectionBorderColor, lineWidth: 1) // border color and width
        )
        .padding(.horizontal, paddingHorizontal)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var todayRoutineSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SCText(title: " Today's Routine", color: .scBlack, font: .system(size: 18, weight: .semibold, design: .rounded), alignment: .leading, kerning: -0.01)
            
            
            if let routines = viewModel.scDay?.routines as? [SCRoutine] {
                
                ForEach(0..<routines.count, id: \.self) { index in
                    routineCards(routine: routines[index])
                }
            }
            
        }
        .padding(.horizontal, paddingHorizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func routineCards(routine: SCRoutine) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 10) {
                    
                }
                
                
            }
            .padding(20)
        }
        .background(sectionBackgroundColor)
        .cornerRadius(sectionCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: sectionCornerRadius)
                .stroke(sectionBorderColor, lineWidth: 1)
        )
        .padding(.horizontal, paddingHorizontal)
        .frame(maxWidth: .infinity)
    }
}
