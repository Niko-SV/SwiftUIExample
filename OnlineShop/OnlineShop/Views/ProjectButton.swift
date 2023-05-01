//
//  ProjectButton.swift
//  OnlineShop
//
//  Created by NikoS on 28.09.2022.
//

import SwiftUI

struct ProjectButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 280, height: 50)
            .font(.title2)
            .background(Color(.systemRed))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
