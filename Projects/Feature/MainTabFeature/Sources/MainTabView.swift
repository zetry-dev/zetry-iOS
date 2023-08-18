//
//  MainTabView.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import CategoryFeature
import ComposableArchitecture
import HomeFeature
import LivingFeature
import SwiftUI

public struct MainTabView: View {
    public let store: StoreOf<MainTabReducer>

    public init(store: StoreOf<MainTabReducer>) {
        self.store = store
    }

    public var body: some View {
        tabView()
    }

    @ViewBuilder
    func tabView() -> some View {
        WithViewStore(self.store, observe: \.selectedTab) { viewStore in
            VStack {
                TabView(selection: viewStore.binding(send: MainTabReducer.Action.tabSelected)) {
                    HomeView(
                        store: self.store.scope(
                            state: \.home,
                            action: MainTabReducer.Action.home
                        )
                    )
                    .tag(MainTabItem.home)

                    CategoryView(
                        store: self.store.scope(
                            state: \.category,
                            action: MainTabReducer.Action.category
                        )
                    )
                    .tag(MainTabItem.category)

                    LivingView(
                        store: self.store.scope(
                            state: \.living,
                            action: MainTabReducer.Action.living
                        )
                    )
                    .tag(MainTabItem.living)
                }
                
                ZenTabView(viewStore: viewStore)
            }
        }
    }
}
