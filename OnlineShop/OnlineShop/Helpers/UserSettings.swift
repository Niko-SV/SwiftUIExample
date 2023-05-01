//
//  UserSettings.swift
//  OnlineShop
//
//  Created by NikoS on 19.09.2022.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    @Published var secondname: String {
        didSet {
            UserDefaults.standard.set(secondname, forKey: "secondname")
        }
    }
    @Published var country: String {
        didSet {
            UserDefaults.standard.set(country, forKey: "country")
        }
    }
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
        self.secondname = UserDefaults.standard.object(forKey: "secondname") as? String ?? ""
        self.country = UserDefaults.standard.object(forKey: "country") as? String ?? ""
    }
}
