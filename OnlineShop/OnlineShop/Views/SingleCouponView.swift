//
//  CouponView.swift
//  OnlineShop
//
//  Created by NikoS on 06.10.2022.
//

import SwiftUI

struct SingleCouponView: View {
    @ObservedObject var viewModel: SingleCouponViewModel
    @State private var buttonText: String = "Copy"
    @State private var blurAmount = 5.0
    private let pasteboard = UIPasteboard.general
    
    var body: some View {
        HStack {
            Text(viewModel.model.name)
            Spacer()
            VStack(alignment: .trailing, spacing: 1) {
                if !viewModel.model.isUsed {
                    promocodeText(viewModel.model.code)
                        .blur(radius: blurAmount)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.6)) {
                                blurAmount = 0.0
                            }
                        }
                    notUsedCouponButton
                } else {
                    promocodeText(viewModel.model.code)
                    usedCouponText
                }
            }
        }
    }
    
    func promocodeText(_ text: String) -> some View {
        Text(text)
            .font(Font.system(size: 20))
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.trailing)
    }
    
    var notUsedCouponButton: some View {
        Button {
            if blurAmount == 0.0 {
                copyToClipboard()
            }
        } label: {
            if blurAmount != 0.0 {
                Text("")
            } else {
                Text(buttonText)
            }
        }
        .foregroundColor(.blue)
    }
    
    var usedCouponText: some View {
        Text("Used")
            .font(Font.system(size: 20))
            .foregroundColor(.red)
    }
    
    func copyToClipboard() {
        pasteboard.string = viewModel.model.code
        self.buttonText = "Copied!"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.buttonText = "Copy"
        }
    }
}
