//
//  CouponsView.swift
//  OnlineShop
//
//  Created by NikoS on 19.09.2022.
//

import SwiftUI

struct CouponsView: View {
    @ObservedObject var viewModel = CouponsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.coupons.isEmpty {
                    noCoupons
                } else {
                    availableCoupons
                }
            }
            .padding()
            .navigationTitle("Available coupons")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var availableCoupons: some View {
        List{
            ForEach(viewModel.coupons.sorted { sortCoupons($0, $1) }) { coupon in
                    SingleCouponView(viewModel: SingleCouponViewModel(model: coupon))
            }
        }
    }

    func sortCoupons(_ first: CouponModel, _ second: CouponModel) -> Bool {
        let numeric1 = first.isUsed ? 0 : 1
        let numeric2 = second.isUsed ? 0 : 1
        if first.isUsed == second.isUsed {
            return first.value > second.value
        }
        return numeric1 > numeric2
    }
    
    var noCoupons: some View {
        Text("No available coupons at the moment.")
    }
    
}

struct CouponsView_Previews: PreviewProvider {
    static var previews: some View {
        CouponsView(viewModel: CouponsViewModel())
    }
}
