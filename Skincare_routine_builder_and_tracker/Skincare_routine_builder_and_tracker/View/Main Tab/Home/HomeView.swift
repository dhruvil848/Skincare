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
            VStack(alignment: .leading, spacing: 30) {
                headerSection
                streakSection
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            SCText(title: "Hi, there  👋🏻", color: .scBlack, font: .system(size: 24, weight: .semibold, design: .none), alignment: .leading)
                .padding(.bottom, 18)
            
            SCText(title: "🔴  Your concern: \(UserDefaultManager.shared.skinConcerns.compactMap({ $0.title }).joined(separator: ", "))", color: .scBlack, font: .system(size: 15, weight: .medium, design: .none), alignment: .leading)
                .padding(.bottom, 6)
            
            SCText(title: "💁🏻‍♀️  Let’s care of your skin today!!", color: .scBlack, font: .system(size: 15, weight: .medium, design: .none), alignment: .leading)
        }
        .padding(.horizontal, paddingHorizontal)
    }
    
    @ViewBuilder
    private var streakSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 12) {
                SCText(title: "🔥 Streak", color: .scBlack, font: .system(size: 18, weight: .medium, design: .default), alignment: .leading)
                
                HStack(alignment: .center, spacing: 15) {
                    SCText(title: "7 Days", color: .scPurple, font: .system(size: 20, weight: .bold, design: .default), alignment: .leading)
                    
                    SCStreakProgressBarView(progress: 0.8)
                }
                
                SCText(title: "You are on the right track, keep it up.", color: .init(hex: "707070"), font: .system(size: 16, weight: .regular, design: .default), alignment: .leading)
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
}
