//
//  SCProgressBarView.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 08/09/25.
//

import SwiftUI

struct SCProgressBarView: View {
    let progress: Float
    let step: String
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            ProgressView(value: progress)
                .tint(.scPurple)
                .frame(maxWidth: .infinity)
            
            Text(step)
                .foregroundStyle(Color.scBlack)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        
    }
}
