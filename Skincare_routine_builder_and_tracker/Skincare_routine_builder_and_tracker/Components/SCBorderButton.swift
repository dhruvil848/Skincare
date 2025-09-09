//
//  SCBorderButton.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 09/09/25.
//

import SwiftUI

struct SCBorderButton: View {
    let action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(Color.scPurple)
                .frame(width: 37, height: 37)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.scBorderGray, lineWidth: 1)
                )
        }
    }
}
