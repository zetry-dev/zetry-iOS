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

            let selection: Binding<MainTabItem> = viewStore.binding(send: { MainTabStore.Action.tabSelected($0) })

            GeometryReader { proxy in
                TabView(selection: selection) {
                    HomeCoordinatorView(
                        store: self.store.scope(
                            state: \.home,
                            action: MainTabStore.Action.home
                        )
                    )
                    .tag(MainTabItem.home)

                    CategoryCoordinatorView(
                        store: self.store.scope(
                            state: \.category,
                            action: MainTabStore.Action.category
                        )
                    )
                    .tag(MainTabItem.category)

                    LivingCoordinatorView(
                        store: self.store.scope(
                            state: \.living,
                            action: MainTabStore.Action.living
                        )
                    )
                    .tag(MainTabItem.living)

                    SettingsCoordinatorView(
                        store: self.store.scope(
                            state: \.settings,
                            action: MainTabStore.Action.settings
                        )
                    )
                    .tag(MainTabItem.settings)
                }
                .safeAreaInset(edge: .bottom) {
                    ZetryTabView(selectedTab: selection, height: proxy.safeAreaInsets.bottom)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}
