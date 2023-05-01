//
//  CouponsModel.swift
//  OnlineShop
//
//  Created by NikoS on 05.10.2022.
//

import Foundation

class CouponModel: Decodable, Identifiable {
    
    var name: String
    var code: String
    var value: Double
    var isUsed: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, code, value
    }

}
