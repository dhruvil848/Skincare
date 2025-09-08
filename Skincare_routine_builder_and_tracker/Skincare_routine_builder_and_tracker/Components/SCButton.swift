//
//  SCButton.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import SwiftUI

struct SCButton: View {
    let title: String
    let onTap: (() -> Void)
    
    var body: some View {
        Button {
            onTap()
        } label: {
            HStack {
                Text(title)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color.scPurple)
            .frame(height: 47)
            .frame(maxWidth: .infinity, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
}
