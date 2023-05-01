//
//  Searchview.swift
//  OnlineShop
//
//  Created by NikoS on 15.09.2022.
//
import SwiftUI

struct SearchResultsView: View {
    var items: [ItemViewModel]
    
    var body: some View {
        List {
            ForEach(items, id: \.model.id) { item in
                NavigationLink(destination: DetailsView(itemViewModel: item), label : {
                    SingleItemView(viewModel: item)
                        .listRowSeparator(.hidden)
                })
            }
        }
        .listStyle(.plain)
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(items: [ItemViewModel]())
    }
}
