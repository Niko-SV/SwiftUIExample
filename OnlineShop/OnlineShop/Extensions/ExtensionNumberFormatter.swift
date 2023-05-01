//
//  ExtensionNumberFOrmatter.swift
//  OnlineShop
//
//  Created by NikoS on 13.09.2022.
//

import Foundation

extension NumberFormatter {
    private static let price = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    static func format(_ priceString: String) -> String {
        guard let priceDouble = Double(priceString), let formattedPrice = price.string(from: NSNumber(value: priceDouble)) else { return "" }
        return formattedPrice
    }
}

