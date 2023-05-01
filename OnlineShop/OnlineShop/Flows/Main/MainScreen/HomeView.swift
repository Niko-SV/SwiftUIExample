//
//  MainView.swift
//  OnlineShop
//
//  Created by NikoS on 07.09.2022.
//

import SwiftUI


struct HomeView: View {

    @ObservedObject var viewModel: CategoryViewModel
    @State private var searchQuery = ""
    @State var isSearchActive = false
    @ObservedObject private var addingToFavorites = AlertControl()
    @ObservedObject private var deleteFromFavorites = AlertControl()
    @State var isTabBarAvailable = true
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.categories, id: \.name) { category in
                            let bottomPadding: CGFloat = (category.name == DataStorage.shared.categoriesModel.last?.name) ? AppConstants.tabBarHeight + 20 : 0
                            categoryView(category: category)
                                .padding(.bottom, bottomPadding)
                        }
                    }
                    .modifier(TabBarOverlay())
                }
                .background(
                    NavigationLink(destination: SearchResultsView(items: filteredItems())
                        .onAppear { isTabBarAvailable = false },
                                   isActive: $isSearchActive ) { EmptyView() }
                        .hidden()
                )
                .padding([.top, .leading, .trailing])
                .onAppear {
                    isTabBarAvailable = true
                }
                .searchable(text: $searchQuery)
                .onSubmit(of: .search) {
                    self.isSearchActive = true
                }
                .coordinateSpace(name: AppConstants.coordinateSpaceName)
                .navigationTitle("Welcome to \(AppConstants.shopName)")
                .navigationBarTitleDisplayMode(.inline)
                .preference(key: IsTabBarAvailableKey.self, value: isTabBarAvailable)
            }
            AlertView(alertText: "Game was added to favorites", imageName: "heart.fill", isVisible: addingToFavorites.isVisible)
            AlertView(alertText: "Game was deleted from favorites", imageName: "heart.fill", isVisible: deleteFromFavorites.isVisible)
        }
        
    }

    func filteredItems() -> [ItemViewModel] {
        guard !searchQuery.isEmpty else { return [] }
        let items = viewModel.categories.flatMap { $0.items }
        let filteredItems = items.filter { $0.title.contains(searchQuery) }
        return filteredItems.map { ItemViewModel(model: $0, layout: .horizontal) }
    }
    
    @ViewBuilder
    func firstCategoryRow(category: CategoryModel) -> some View {
        if category.name == DataStorage.shared.categoriesModel.first?.name {
            VStack(alignment: .leading) {
                NavigationLink {
                    BasketView()
                        .onAppear{ isTabBarAvailable = false }
                } label: {
                    Spacer()
                    Image(systemName: "cart.fill")
                }
                .foregroundColor(.gray)
                .font(.system(size: 20))
                .padding(.horizontal, 5)
                Text("Category: \(category.name)")
                    .font(.title)
                    .foregroundColor(.black)
            }
        } else {
            Text("Category: \(category.name)")
        }
    }
    
    func categoryView(category: CategoryModel) -> some View {
        VStack(alignment: .leading) {
            firstCategoryRow(category: category)
                .font(.title)
                .foregroundColor(.black)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(category.items, id: \.id) { game in
                        NavigationLink(destination: DetailsView(itemViewModel: ItemViewModel(model: game, layout: .horizontal))
                            .onAppear { isTabBarAvailable = false }, label : {
                                SingleItemView(viewModel: ItemViewModel(model: game, layout: .vertical))
                            })
                        .highPriorityGesture(
                            TapGesture(count: 2)
                                .onEnded({
                                    if !game.isFavorite {
                                        addingToFavorites.show()
                                    } else {
                                        deleteFromFavorites.show()
                                    }
                                    game.isFavorite.toggle()
                                })
                        )
                    }
                }
            }
        }
    }
    
    func itemView(imageName: String, itemTitle: String, price: String) -> some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 150)
            Text(itemTitle + "\n")
                .foregroundColor(.primary)
                .font(.title3)
                .multilineTextAlignment(.leading)
                .frame(width: 150, alignment: .leading)
                .lineLimit(2)
                .fixedSize()
            HStack {
                Text(NumberFormatter.format(price))
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
    
}

struct MainView_Previews: PreviewProvider {
    @State static var isTabBarAvailable = false
    static var previews: some View {
        HomeView(viewModel: CategoryViewModel())
    }
}
