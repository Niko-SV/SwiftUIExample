//
//   CouponViewModel.swift
//  OnlineShop
//
//  Created by NikoS on 06.10.2022.
//

import Foundation
import Combine

class CouponsViewModel: ObservableObject {
    var coupons: [CouponModel] {
        DataStorage.shared.couponsModel
    }
    var couponSubscription: AnyCancellable?
    
    init() {
        couponSubscription = DataStorage.shared.$couponsModel.sink{ [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
}
