//
//  BoadGamesModel.swift
//  OnlineShop
//
//  Created by NikoS on 08.09.2022.
//

import Foundation

struct CategoryModel: Decodable {
    
    var name: String
    var items: [Item]
}

class Item: Decodable, Identifiable, ObservableObject {
    var id: Int
    var title: String
    var year: Int
    var price: Double
    var image: [String]
    var description: String
    var isFavorite: Bool = false
    @Published var inBasket: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, year, price, image, description
    }
}
