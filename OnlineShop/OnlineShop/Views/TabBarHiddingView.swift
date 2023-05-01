//
//  TabBarHiddingView.swift
//  OnlineShop
//
//  Created by NikoS on 13.09.2022.
//

import SwiftUI

struct TabBarHiddingView: View {
    @ObservedObject var viewModel: TabBarHiddingViewModel
    @State var tabBarIsHidden: Bool = false
    
    var body: some View {
        GeometryReader { proxy -> Color in
            viewModel.handleScroll(proxy: proxy) {
                tabBarIsHidden = $0
            }
            return Color.clear
        }
        .preference(key: HideTabBarKey.self, value: .init(value: tabBarIsHidden))
    }
}

class TabBarHiddingViewModel: ObservableObject {
    
    @Published var offset: CGFloat = 0
    private var lastOffset: CGFloat = 0
    var scrollToleranse: CGFloat = 15
    var animation: Animation = .easeOut.speed(1.5)
    let coordinateSpaceName: String
    
    init(coordinateSpaceName: String, scrollToleranse: CGFloat = 15, animation: Animation = .easeOut.speed(1.5)) {
        self.coordinateSpaceName = coordinateSpaceName
        self.scrollToleranse = scrollToleranse
        self.animation = animation
    }
    
    func handleScroll(proxy: GeometryProxy, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            self.updateOffset(proxy: proxy, completion: completion)
        }
    }
    
    private func updateOffset(proxy: GeometryProxy, completion: (Bool) -> Void) {
        let minY = proxy.frame(in: .named(coordinateSpaceName)).minY
        if minY < offset {
            if offset < 0 && -minY > (lastOffset + scrollToleranse) {
                withAnimation(animation) {
                    completion(true)
                }
                lastOffset = -offset
            }
        }
        if minY > offset && -minY < (lastOffset - scrollToleranse) {
            withAnimation(.easeOut.speed(1.5)) {
                completion(false)
            }
            lastOffset = -offset
        }
        if offset != minY {
            offset = minY
        }
    }
}
