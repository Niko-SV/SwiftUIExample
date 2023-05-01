//
//  ItemView.swift
//  OnlineShop
//
//  Created by NikoS on 19.09.2022.
//

import SwiftUI

struct SingleItemView: View {
    @ObservedObject var viewModel: ItemViewModel
    
    var body: some View {
        switch viewModel.layout {
        case .vertical:
            showVertical()
        case .horizontal:
            showHorizontal()
        }
    }
    
    @ViewBuilder private var image: some View {
        let image = Image(viewModel.model.image[0])
        if viewModel.model.isFavorite {
            image
                .resizable()
                .frame(width: 150, height: 150)
                .overlay(Badge())
        } else {
            image
                .resizable()
                .frame(width: 150, height: 150)
        }
    }
    
    
    func showVertical() -> some View {
        VStack(alignment: .leading) {
            image
            Text(viewModel.model.title + "\n")
                .foregroundColor(.primary)
                .font(.title3)
                .multilineTextAlignment(.leading)
                .frame(width: 150, alignment: .leading)
                .lineLimit(2)
                .fixedSize()
            HStack {
                Text(NumberFormatter.format(String(viewModel.model.price)))
                    .font(.title2)
                    .foregroundColor(.primary)
                    .fixedSize()
                VStack{
                    Divider().background(.black)
                }
            }
            Spacer()
        }
    }
    func showHorizontal() -> some View {
        HStack(spacing: 20) {
            Image(viewModel.model.image[0])
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .frame(width: 125, height: 125)
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.model.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Text(NumberFormatter.format(String(viewModel.model.price)))
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .font(.title3)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct Badge: View {

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Image(systemName: "heart.fill")
                .foregroundColor(.red)
                .frame(width: 25, height: 25)
                .padding(5)
                .offset(x: 5, y: -5)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let item = DataStorage.shared.item(by: 12)!
        SingleItemView(viewModel: ItemViewModel(model: item, layout: .vertical))
    }
}
