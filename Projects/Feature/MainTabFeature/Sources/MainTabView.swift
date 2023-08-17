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
            TabView(selection: viewStore.binding(send: MainTabReducer.Action.tabSelected)) {
                Group {
                    HomeView(
                        store: self.store.scope(state: \.home, action: MainTabReducer.Action.home)
                    )
                    .tabItem {
                        VStack(spacing: 4) {
                            Image(systemName: MainTabItem.home.icon)
                                .renderingMode(.template)
                                .foregroundColor(viewStore.state == MainTabItem.home ? Color.black : Color.gray)
                            Text(MainTabItem.home.description)
                                .foregroundColor(viewStore.state == MainTabItem.home ? Color.black : Color.gray)
                        }
                    }
                    .tag(MainTabItem.home)

                    CategoryView(
                        store: self.store.scope(state: \.category, action: MainTabReducer.Action.category)
                    )
                    .tabItem {
                        VStack(spacing: 4) {
                            Image(systemName: MainTabItem.category.icon)
                                .renderingMode(.template)
                                .foregroundColor(viewStore.state == MainTabItem.category ? Color.black : Color.gray)
                            Text(MainTabItem.category.description)
                                .foregroundColor(viewStore.state == MainTabItem.category ? Color.black : Color.gray)
                        }
                    }
                    .tag(MainTabItem.category)

                    LivingView(
                        store: self.store.scope(state: \.living, action: MainTabReducer.Action.living)
                    )
                    .tabItem {
                        VStack(spacing: 4) {
                            Image(systemName: MainTabItem.living.icon)
                                .renderingMode(.template)
                                .foregroundColor(viewStore.state == MainTabItem.living ? Color.black : Color.gray)
                            Text(MainTabItem.living.description)
                                .foregroundColor(viewStore.state == MainTabItem.living ? Color.black : Color.gray)
                        }
                    }
                    .tag(MainTabItem.living)
                }
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.light, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
            }
        }
    }
}
