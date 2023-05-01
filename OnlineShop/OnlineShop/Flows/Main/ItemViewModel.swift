//
//  ItemViewModel.swift
//  OnlineShop
//
//  Created by NikoS on 19.09.2022.
//

import Foundation
import Combine

class ItemViewModel: ObservableObject, Hashable, Equatable {
    
    static func == (lhs: ItemViewModel, rhs: ItemViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    enum Layout {
        case horizontal
        case vertical
    }
    
    private var id = UUID().uuidString
    var model: Item
    var layout: Layout
    private var subscription: AnyCancellable?
    
    init(model: Item, layout: Layout) {
        self.model = model
        self.layout = layout
        subscription = model.objectWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
