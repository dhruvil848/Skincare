//
//  SCText.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import SwiftUI

struct SCText: View {
    
    let title: String
    let color: Color
    let font: Font
    var lineLimit: Int? = nil
    var alignment: TextAlignment = .center
    
    var body: some View {
        Text(title)
            .font(font)
            .foregroundStyle(color)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
    }
}

#Preview {
    SCText(title: "Test", color: .scPurple, font: .system(size: 17, weight: .regular))
}
