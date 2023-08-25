//
//  MainTabView.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CategoryFeature
import ComposableArchitecture
import DesignSystem
import HomeFeature
import LivingFeature
import SwiftUI

public struct MainTabView: View {
    public let store: StoreOf<MainTabStore>

    public init(store: StoreOf<MainTabStore>) {
        self.store = store
    }

    public var body: some View {
        tabView()
    }

    @ViewBuilder
    func tabView() -> some View {
        WithViewStore(self.store, observe: \.selectedTab) { viewStore in
            TabView(selection: viewStore.binding(send: { MainTabStore.Action.tabSelected($0) })) {
                HomeCoordinatorView(
                    store: self.store.scope(
                        state: \.home,
                        action: MainTabStore.Action.home
                    )
                )
                .tabItem {
                    VStack {
                        ZetryIcon(MainTabItem.home.icon)
                        Text(MainTabItem.home.description)
                            .fontStyle(.label4)
                    }
                }
                .tag(MainTabItem.home)

                CategoryCoordinatorView(
                    store: self.store.scope(
                        state: \.category,
                        action: MainTabStore.Action.category
                    )
                )
                .tabItem {
                    VStack {
                        ZetryIcon(MainTabItem.category.icon)
                        Text(MainTabItem.category.description)
                            .fontStyle(.label4)
                    }
                }
                .tag(MainTabItem.category)

                LivingCoordinatorView(
                    store: self.store.scope(
                        state: \.living,
                        action: MainTabStore.Action.living
                    )
                )
                .tabItem {
                    VStack {
                        ZetryIcon(MainTabItem.living.icon)
                        Text(MainTabItem.living.description)
                            .fontStyle(.label4)
                    }
                }
                .tag(MainTabItem.living)
            }
        }
    }
}
