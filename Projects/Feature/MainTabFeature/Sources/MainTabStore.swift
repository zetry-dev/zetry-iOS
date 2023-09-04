//
//  MainTabStore.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import CategoryFeature
import HomeFeature
import LivingFeature
import SettingsFeature

public struct MainTabStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public var selectedTab: MainTabItem

        public var home: HomeCoordinator.State = .init()
        public var category: CategoryCoordinator.State = .init()
        public var living: LivingCoordinator.State = .init()
        public var settings: SettingsCoordinator.State = .init()

        public init(selectedTab: MainTabItem = .home) {
            self.selectedTab = selectedTab
        }
    }

    public enum Action {
        case tabSelected(MainTabItem)
        case home(HomeCoordinator.Action)
        case category(CategoryCoordinator.Action)
        case living(LivingCoordinator.Action)
        case settings(SettingsCoordinator.Action)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
            default:
                return .none
            }
        }

        Scope(state: \.home, action: /Action.home, child: {
            HomeCoordinator()
        })

        Scope(state: \.category, action: /Action.category, child: {
            CategoryCoordinator()
        })

        Scope(state: \.living, action: /Action.living, child: {
            LivingCoordinator()
        })

        Scope(state: \.settings, action: /Action.settings, child: {
            SettingsCoordinator()
        })
    }
}
