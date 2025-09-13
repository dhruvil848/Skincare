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
    var kerning: CGFloat = 0
    var italic: Bool = false
    var lineSpacing: CGFloat? = nil
    
    var body: some View {
        Text(title)
            .strikethrough(italic, color: .gray)
            .font(font)
            .foregroundStyle(color)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
            .kerning(kerning)
            .if(lineSpacing != nil) { text in
                text.lineSpacing(lineSpacing!)
            }
    }
}

#Preview {
    SCText(title: "Test", color: .scPurple, font: .system(size: 17, weight: .regular))
}
