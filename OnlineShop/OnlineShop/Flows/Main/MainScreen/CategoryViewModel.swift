//
//  HomeViewModel.swift
//  OnlineShop
//
//  Created by NikoS on 19.09.2022.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    var categories: [CategoryModel] {
        DataStorage.shared.categoriesModel
    }
    var categorySubscription: AnyCancellable?
    
    init() {
        categorySubscription = DataStorage.shared.$categoriesModel.sink{ [weak self] _ in
            self?.objectWillChange.send()
        }
    }
}
