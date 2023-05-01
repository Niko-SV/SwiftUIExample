//
//  ScrollViewTextFadeAway.swift
//  OnlineShop
//
//  Created by NikoS on 03.10.2022.
//

import SwiftUI

struct ScrollViewTextFadeAway: ViewModifier {
    func body(content: Content) -> some View {
        content
            .mask(
                VStack(spacing: 0) {
                    LinearGradient(gradient:
                                    Gradient(
                                        colors: [Color.black.opacity(0), Color.black]),
                                   startPoint: .top, endPoint: .bottom
                    )
                    .frame(height: 20)
                    Rectangle().fill(Color.black)
                    LinearGradient(gradient:
                                    Gradient(
                                        colors: [Color.black, Color.black.opacity(0)]),
                                   startPoint: .top, endPoint: .bottom
                    )
                    .frame(height: 20)
                    
                }
            )
    }
}
