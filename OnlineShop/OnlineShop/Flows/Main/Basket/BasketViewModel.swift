//
//  BasketViewModel.swift
//  OnlineShop
//
//  Created by NikoS on 04.10.2022.
//

import Foundation

final class BasketViewModel: ObservableObject {
    private(set) var items: [ItemViewModel]
    
    init() {
        let models = DataStorage.shared.getAllInBasket()
        items = models.map { ItemViewModel(model: $0, layout: .horizontal) }
    }
    
    func deleteFromBasket(_ item: ItemViewModel) {
        items.removeAll{ $0 == item }
        item.model.inBasket = false
        objectWillChange.send()
    }
    
    func isValidPhoneNumber(phone: String) -> Bool {
        let phoneRegex = "^(?:\\+38)?(0[5-9][0-9]\\d{7})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    func phoneNumberPrompt(_ phoneNumber: String) -> String {
        if isValidPhoneNumber(phone: phoneNumber) {
            return ""
        } else {
            return "Enter a valid phone number"
        }
    }
}
