//
//  SingleCouponViewModel.swift
//  OnlineShop
//
//  Created by NikoS on 06.10.2022.
//

import Foundation

class SingleCouponViewModel: ObservableObject {
    
    var model: CouponModel
    
    init(model: CouponModel) {
        self.model = model
    }
}
