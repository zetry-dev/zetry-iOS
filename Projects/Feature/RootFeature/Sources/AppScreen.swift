//
//  AppCoordinator.swift
//  RootFeature
//
//  Created by Allie Kim on 2023/08/20.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import LaunchScreenFeature
import MainTabFeature
import TCACoordinators

public struct AppScreen: Reducer {
    public enum State: Equatable {
        case launch(LaunchScreenStore.State)
        case mainTab(MainTabStore.State)
    }

    public enum Action {
        case launch(LaunchScreenStore.Action)
        case mainTab(MainTabStore.Action)
    }

    public var body: some ReducerOf<Self> {
        Scope(state: /State.launch, action: /Action.launch) {
            LaunchScreenStore()
        }
        Scope(state: /State.mainTab, action: /Action.mainTab) {
            MainTabStore()
        }
    }
}
