//
//  MainTabView.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import CategoryFeature
import DesignSystem
import HomeFeature
import LivingFeature
import SettingsFeature
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
                .tabItem(.home)

                CategoryCoordinatorView(
                    store: self.store.scope(
                        state: \.category,
                        action: MainTabStore.Action.category
                    )
                )
                .tabItem(.category)

                LivingCoordinatorView(
                    store: self.store.scope(
                        state: \.living,
                        action: MainTabStore.Action.living
                    )
                )
                .tabItem(.living)

                SettingsCoordinatorView(
                    store: self.store.scope(
                        state: \.settings,
                        action: MainTabStore.Action.settings
                    )
                )
                .tabItem(.settings)
            }
        }
    }
}

extension View {
    @ViewBuilder
    func tabItem(_ tab: MainTabItem) -> some View {
        self.tabItem {
            VStack {
                ZetryIcon(tab.icon)
                Text(tab.description)
                    .fontStyle(.label4)
            }
        }
        .tag(tab)
    }
}
