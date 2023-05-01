//
//  PurchasesView.swift
//  OnlineShop
//
//  Created by NikoS on 07.09.2022.
//

import SwiftUI

struct PurchasesView: View {
    @State var isTabBarAvailable = true
    var purchases = DataStorage.shared.purchases

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(purchases, id: \.id) { item in
                    let bottomPadding: CGFloat = (item.fullPrice == DataStorage.shared.purchases.last?.fullPrice) ? AppConstants.tabBarHeight + 20 : 0
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(item.model, id: \.model.id) { game in
                                    SingleItemView(viewModel: game)
                                }
                            }
                        }
                        .padding([.horizontal])
                        Form {
                            Section(header: Text("Customer's Info")) {
                                Text(item.firstName)
                                Text(item.secondName)
                                Text(item.address)
                                Text(item.phoneNumber)
                                Text("Delivery method: \(item.deliveryMethod)")
                                Text("Total price: \(NumberFormatter.format(String(item.fullPrice)))")
                            }
                        }
                        .disabled(true)
                        .frame(height: 320)
                    }
                    .padding(.bottom, bottomPadding)
                    .modifier(TabBarOverlay())
                }
            }
            .coordinateSpace(name: AppConstants.coordinateSpaceName)
            .preference(key: IsTabBarAvailableKey.self, value: isTabBarAvailable)
            .navigationTitle("Purchases")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
    
struct PurchasesView_Previews: PreviewProvider {
    static var previews: some View {
        PurchasesView()
    }
}
