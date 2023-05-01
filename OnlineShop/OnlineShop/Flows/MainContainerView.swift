//
//  MainView.swift
//  OnlineShop
//
//  Created by NikoS on 14.09.2022.
//

import SwiftUI

struct MainContainerView: View {
    @State private var selectedTab: Tabs = .home
    
    private var viewModel = CategoryViewModel()
    
    var body: some View {
        TabBarNavigationView { selectedTab in
            VStack {
                switch selectedTab {
                case .home:
                    HomeView(viewModel: viewModel)
                case .purchases:
                    PurchasesView()
                case .profile:
                    ProfileView()
                }
            }
        }
    }
}

struct MainContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerView()
    }
}
