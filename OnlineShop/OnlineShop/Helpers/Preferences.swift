//
//  Preferences.swift
//  OnlineShop
//
//  Created by NikoS on 22.09.2022.
//

import SwiftUI

struct HideBarValue: Equatable {
    var value = true
}

struct HideTabBarKey: PreferenceKey {
    static var defaultValue: HideBarValue = .init(value: false)
    
    static func reduce(value: inout HideBarValue, nextValue: () -> HideBarValue) {
        value.value = value.value || nextValue().value
    }
}

struct IsTabBarAvailableKey: PreferenceKey {
    static var defaultValue = true
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = value && nextValue()
    }
    
}
