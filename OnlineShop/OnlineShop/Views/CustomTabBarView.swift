//
//  CustomTabBar.swift
//  OnlineShop
//
//  Created by NikoS on 07.09.2022.
//

import SwiftUI

enum Tabs: String, CaseIterable {
    case home
    case purchases
    case profile
}

struct CustomTabBarView: View {
    @Binding var selectedTab: Tabs
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tabs.allCases, id: \.rawValue) { tab in
                    Spacer()
                    VStack{
                        Image(systemName: iconName(tab: tab))
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("\(tab.rawValue.capitalized)")
                            .font(.system(size: 12))
                    }
                    .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                    .foregroundColor(selectedTab == tab ? tabColor() : .gray)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.2)){
                            selectedTab = tab
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: nil, height: AppConstants.tabBarHeight)
            .background(.thinMaterial)
            .cornerRadius(AppConstants.tabBarHeight / 2)
            .padding(.horizontal)
            .padding(.bottom, AppConstants.tabBarBottomPadding)
        }
    }
    
    private func tabColor() -> Color {
        switch selectedTab {
        case .home:
            return .red
        case .purchases:
            return .brown
        case .profile:
            return .purple
        }
    }
    
    private func iconName(tab: Tabs) -> String {
        switch tab {
        case .home:
            return "bag"
        case .purchases:
            return "checkmark"
        case .profile:
            return "person"
        }
    }
}

struct CustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(selectedTab: .constant(.home))
    }
}
