//
//  DataStorage.swift
//  OnlineShop
//
//  Created by NikoS on 19.09.2022.
//

import SwiftUI
import Combine

class DataStorage {
    static let shared = DataStorage()
    @Published var categoriesModel = [CategoryModel]()
    @Published var purchaseModel = [PurchaseModel]()
    @Published var couponsModel = [CouponModel]()
    private var boardGameSubscription: AnyCancellable?
    private var couponsSubscription: AnyCancellable?
    var purchases: [PurchaseViewModel] = []
    
    func getBoardGames() {
        boardGameSubscription = Bundle.main.decodeable(fileName: AppConstants.dataFileName)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] categoriesData in
                self?.categoriesModel = categoriesData
            }
    }
    
    func getCoupons() {
        couponsSubscription = Bundle.main.decodeable(fileName: AppConstants.couponsFileName)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] couponsData in
                self?.couponsModel = couponsData
            }
    }
    
    func item(by id: Int) -> Item? {
        let items = categoriesModel.flatMap { $0.items }
        return items.first { $0.id == id }
    }
    
    func getAllFavorites() -> [Item] {
        let items = categoriesModel.flatMap { $0.items }
        return items.filter { $0.isFavorite }
    }
    
    func getAllInBasket() -> [Item] {
        let items = categoriesModel.flatMap { $0.items }
        return items.filter { $0.inBasket }
    }
    
}
