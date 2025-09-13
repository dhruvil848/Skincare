//
//  SCGradient.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import SwiftUI

struct SCGredientBG: View {

    let skincareGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color(hex: "FFF9FB"),
            Color(hex: "FFF9FB")
        ]),
        startPoint: .top,
        endPoint: .bottom
    )

    var body: some View {
        Rectangle()
                .fill(skincareGradient)
                .ignoresSafeArea()
    }
}

#Preview {
    SCGredientBG()
}
