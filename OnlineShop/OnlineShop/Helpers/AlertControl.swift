//
//  AddingToGroupActionView.swift
//  OnlineShop
//
//  Created by NikoS on 26.09.2022.
//

import SwiftUI

class AlertControl: ObservableObject {
    @Published var isVisible = false
    
    func show(animationDuration: Double = 0.3, showingDuration: Double = 2) {
        withAnimation(.easeIn(duration: animationDuration)) {
            isVisible = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + showingDuration) {
            self.isVisible = false
        }
    }
}
