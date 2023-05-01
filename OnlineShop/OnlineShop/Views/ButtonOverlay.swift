//
//  Badge.swift
//  OnlineShop
//
//  Created by NikoS on 04.10.2022.
//

import SwiftUI

struct ButtonOverlay: View {
    var action: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Button {
                action()
            } label: {
                Image(systemName: "trash.fill")
                    .foregroundColor(.red)
                    .frame(width: 25, height: 25)
                    .padding(5)
                    .offset(x: 5, y: -5)
            }
        }
    }
}
