//
//  TabBarNavigationView.swift
//  OnlineShop
//
//  Created by NikoS on 23.09.2022.
//

import SwiftUI

struct TabBarNavigationView<Content>: View where Content: View {
    let content: (Tabs) -> Content
    @State var hideBar = false
    @State var isTabBarAvailable = true
    @State private var selectedTab: Tabs = .home
    
    var body: some View {
        ZStack {
            let tabBarOffset = hideBar || !isTabBarAvailable ? AppConstants.tabBarHeight * 2 : 0
            content(selectedTab)
                .onPreferenceChange(HideTabBarKey.self) { hideBar in
                    self.hideBar = hideBar.value
                }
                .onPreferenceChange(IsTabBarAvailableKey.self) { isTabBarAvailable in
                    self.isTabBarAvailable = isTabBarAvailable
                }
                
            VStack {
                Spacer()
                CustomTabBarView(selectedTab: $selectedTab)
            }
            .offset(y: tabBarOffset).animation(.easeOut, value: tabBarOffset)
        }
    }
}

