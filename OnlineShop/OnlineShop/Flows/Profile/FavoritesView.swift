//
//  FavoritesView.swift
//  OnlineShop
//
//  Created by NikoS on 19.09.2022.
//

import SwiftUI

struct FavoritesView: View {
    @State var items: [ItemViewModel]
    
    var body: some View {
        ZStack {
            if items.isEmpty {
                emptyFavorites
            } else {
                favoritesWereAdded
            }
        }
        .navigationTitle("Favorites")
    }
    
    var emptyFavorites: some View {
        Text("No favorite games yet")
    }
    
    var favoritesWereAdded: some View {
        List {
            ForEach(items, id: \.model.id) { item in
                NavigationLink(destination: DetailsView(itemViewModel: item), label : {
                    SingleItemView(viewModel: item)
                        .listRowSeparator(.hidden)
                })
            }
            .onDelete(perform: delete)
        }
        .listStyle(.plain)
    }
    
    func delete(at offset: IndexSet) {
        let idsToDelete = offset.map { self.items[$0].model.id }
        DataStorage.shared.getAllFavorites()
            .filter{idsToDelete.contains($0.id)}
            .forEach { $0.isFavorite = false }
        items.remove(atOffsets: offset)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(items: [ItemViewModel]())
    }
}
