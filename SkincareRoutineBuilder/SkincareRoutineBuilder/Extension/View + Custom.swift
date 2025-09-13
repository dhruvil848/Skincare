//
//  View + Custom.swift
//  Skincare_routine_builder_and_tracker
//
//  Created by Dhruvil Moradiya on 10/09/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool,
                             transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

