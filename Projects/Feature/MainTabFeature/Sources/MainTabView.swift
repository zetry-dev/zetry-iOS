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

            VStack(spacing: 0) {
                switch selection.wrappedValue {
                    case .home:
                        HomeCoordinatorView(
                            store: self.store.scope(
                                state: \.home,
                                action: MainTabStore.Action.home
                            )
                        )
                    case .category:
                        CategoryCoordinatorView(
                            store: self.store.scope(
                                state: \.category,
                                action: MainTabStore.Action.category
                            )
                        )
                    case .living:
                        LivingCoordinatorView(
                            store: self.store.scope(
                                state: \.living,
                                action: MainTabStore.Action.living
                            )
                        )
                    case .settings:
                        SettingsCoordinatorView(
                            store: self.store.scope(
                                state: \.settings,
                                action: MainTabStore.Action.settings
                            )
                        )
                }
                ZetryTabView(selectedTab: selection)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
