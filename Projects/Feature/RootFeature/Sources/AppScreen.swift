//
//  AppCoordinator.swift
//  RootFeature
//
//  Created by Allie Kim on 2023/08/20.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import LaunchScreenFeature
import MainTabFeature
import ProductDetailFeature
import SearchFeature

public struct AppScreen: Reducer {
    public enum State: Equatable {
        case launch(LaunchScreenStore.State)
        case mainTab(MainTabStore.State)
        case search(SearchStore.State)
        case detail(ProductDetailStore.State)
    }

    public enum Action {
        case launch(LaunchScreenStore.Action)
        case mainTab(MainTabStore.Action)
        case search(SearchStore.Action)
        case detail(ProductDetailStore.Action)
    }

    public var body: some ReducerOf<Self> {
        Scope(state: /State.launch, action: /Action.launch) {
            LaunchScreenStore()
        }
        Scope(state: /State.mainTab, action: /Action.mainTab) {
            MainTabStore()
        }
        Scope(state: /State.search, action: /Action.search) {
            SearchStore()
        }
        Scope(state: /State.detail, action: /Action.detail) {
            ProductDetailStore()
        }
    }
}
