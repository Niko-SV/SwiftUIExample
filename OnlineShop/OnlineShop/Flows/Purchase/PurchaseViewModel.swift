//
//  PurchaseViewModel.swift
//  OnlineShop
//
//  Created by NikoS on 29.09.2022.
//

import Foundation

class PurchaseViewModel: ObservableObject {
    
    var id: UUID
    var model: [ItemViewModel]
    var deliveryMethod: String
    var firstName: String
    var secondName: String
    var address: String
    var phoneNumber: String
    var fullPrice: Double
    
    init(id: UUID, model: [ItemViewModel], deliveryMethod: String, firstName: String, secondName: String, address: String, fullPrice: Double, phoneNumber: String) {
        self.id = id
        self.model = model
        self.deliveryMethod = deliveryMethod
        self.firstName = firstName
        self.secondName = secondName
        self.address = address
        self.phoneNumber = phoneNumber
        self.fullPrice = fullPrice
    }
    
}
