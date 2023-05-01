//
//  Alert.swift
//  OnlineShop
//
//  Created by NikoS on 26.09.2022.
//

import SwiftUI

struct AlertView: View {
    var alertText: String
    var imageName: String
    var isVisible: Bool
    
    var body: some View {
        if isVisible {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color.gray)
                .frame(width: 200, height: 200)
                .overlay(
                    VStack {
                        Image(systemName: imageName)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text(alertText).font(.title2)
                            .multilineTextAlignment(.center)
                    }
                )
        }
    }
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(alertText: "Name", imageName: "star", isVisible: true)
    }
}
