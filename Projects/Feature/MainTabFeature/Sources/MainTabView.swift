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
    public let store: StoreOf<MainTabCore>

    public init(store: StoreOf<MainTabCore>) {
        self.store = store
    }

    public var body: some View {
        tabView()
    }

    @ViewBuilder
    func tabView() -> some View {
        WithViewStore(self.store, observe: \.selectedTab) { viewStore in
            VStack {
//                TabView(selection: viewStore.binding(send: MainTabCore.Action.tabSelected)) {
//                    HomeView(
//                        store: self.store.scope(
//                            state: \.home,
//                            action: MainTabCore.Action.home
//                        )
//                    )
//                    .tag(MainTabItem.home)
//
//                    CategoryView(
//                        store: self.store.scope(
//                            state: \.category,
//                            action: MainTabCore.Action.category
//                        )
//                    )
//                    .tag(MainTabItem.category)
//
//                    LivingView(
//                        store: self.store.scope(
//                            state: \.living,
//                            action: MainTabCore.Action.living
//                        )
//                    )
//                    .tag(MainTabItem.living)
//                }

                ZenTabView(viewStore: viewStore)
            }
        }
    }
}
