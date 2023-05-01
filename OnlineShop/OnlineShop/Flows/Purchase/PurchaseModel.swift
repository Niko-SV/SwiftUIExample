//
//  PurchaseModel.swift
//  OnlineShop
//
//  Created by NikoS on 29.09.2022.
//

import Foundation

struct PurchaseModel: Identifiable {
    
    var id: UUID
    var purchasedItems: [ItemViewModel]
    var firstName: String
    var secondName: String
    var address: String
    var phoneNumber: String
    var deliveryMethod: String
    var totalPrice: Double
}
