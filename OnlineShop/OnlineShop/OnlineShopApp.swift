//
//  OnlineShopApp.swift
//  OnlineShop
//
//  Created by NikoS on 07.09.2022.
//

import SwiftUI

@main
struct OnlineShopApp: App {
    var body: some Scene {
        WindowGroup {
            MainContainerView()
        }
    }
    init() {
        DataStorage.shared.getBoardGames()
        DataStorage.shared.getCoupons()
    }
}
