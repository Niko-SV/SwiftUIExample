//
//  TabBarOverlay.swift
//  OnlineShop
//
//  Created by NikoS on 23.09.2022.
//

import SwiftUI

struct TabBarOverlay: ViewModifier {
    var htbViewModel = TabBarHiddingViewModel(coordinateSpaceName: AppConstants.coordinateSpaceName)
    func body(content: Content) -> some View {
        content
        .overlay(
            TabBarHiddingView(viewModel: htbViewModel)
        )
    }
}
