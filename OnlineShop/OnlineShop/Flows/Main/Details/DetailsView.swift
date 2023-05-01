//
//  DetailsView.swift
//  OnlineShop
//
//  Created by NikoS on 14.09.2022.
//

import SwiftUI

struct DetailsView: View {
    var itemViewModel: ItemViewModel
    @ObservedObject var addingToBasket = AlertControl()
    @ObservedObject var alreadyInBasket = AlertControl()
    @State var index = 0
    
    
    var body: some View {
        ZStack {
            VStack {
                image
                title
                year
                ScrollView {
                    description
                }
                .modifier(ScrollViewTextFadeAway())
                .padding(.horizontal, 15)
                Spacer(minLength: 25)
                Button("Add to basket") {
                    if !itemViewModel.model.inBasket {
                        itemViewModel.model.inBasket = true
                        addingToBasket.show()
                    } else {
                        alreadyInBasket.show()
                    }
                }
                .modifier(ProjectButton())
                .padding(.bottom)
            }
            AlertView(alertText: "Game was added to basket", imageName: "cart.fill", isVisible: addingToBasket.isVisible)
            AlertView(alertText: "Game is already in basket", imageName: "cart.fill", isVisible: alreadyInBasket.isVisible)
        }    }
    
    private var image: some View {
        PagingView(index: $index.animation(), maxIndex:  itemViewModel.model.image.count-1) {
            ForEach(itemViewModel.model.image, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
            }
        }
        .aspectRatio(4/3, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    private var title: some View {
        Text(itemViewModel.model.title)
            .font(.title2)
            .fontWeight(.semibold)
            .lineLimit(2)
            .multilineTextAlignment(.center)
    }
    
    private var year: some View {
        Text(verbatim: "\(itemViewModel.model.year)")
            .font(.title3)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.bottom, 25)
    }
    
    private var description: some View {
        Text(itemViewModel.model.description)
            .multilineTextAlignment(.center)
            .font(.title3)
            .frame(width: UIScreen.main.bounds.width - 30)
    }
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let item = DataStorage.shared.item(by: 12)!
        DetailsView(itemViewModel: ItemViewModel(model: item, layout: .horizontal))
    }
}
