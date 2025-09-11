//
//  SCNavBackButton.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 11/09/25.
//

import SwiftUI

struct SCNavBackButton: View {
    let action: (() -> Void)


    var body: some View {
        VStack(spacing: 2) {
            Button {
                action()
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.scPurple)
                    .frame(width: 35, height: 35)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.scBorderGray, lineWidth: 1)
                    )
            }
        }
    }
}
