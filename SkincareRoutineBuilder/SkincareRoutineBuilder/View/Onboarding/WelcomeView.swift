//
//  WelcomeView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import SwiftUI

struct WelcomeView: View {

    var body: some View {
        ZStack {
            SCGredientBG()
            
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                Image("onboarding_hello")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 20)
                
                Spacer()
                
                
                SCText(
                    title: "Welcome to Skincare",
                    color: .scBlack,
                    font: .system(size: 26, weight: .semibold)
                )
                .padding(.bottom, 5)
                
                SCText(
                    title: "Build your best skincare routine",
                    color: .scBlack,
                    font: .system(size: 16, weight: .regular)
                )

                Spacer()

                SCText(
                    title: "Let's get to know your skin to create a\npersonalized routine just for you.",
                    color: .scBlack,
                    font: .system(size: 16, weight: .regular)
                )
                
                Spacer()
                
                SCButton(title: "Build your routine") {
                    NavigationManager.shared.push(to: .whatSkinTypeView)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
            }
        }
    }
}

#Preview {
    WelcomeView()
}
