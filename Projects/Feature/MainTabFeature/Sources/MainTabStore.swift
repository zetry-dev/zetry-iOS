//
//  MainTabStore.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import CategoryFeature
import ComposableArchitecture
import HomeFeature
import LivingFeature
import SettingsFeature

public struct MainTabStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public var selectedTab: MainTabItem

        public var home: HomeCoordinator.State = .init()
        public var category: CategoryCoordinator.State
        public var living: LivingCoordinator.State
        public var settings: SettingsCoordinator.State = .init()

        public init(selectedTab: MainTabItem = .home, selectedCategory: String = "종이류", selectedLiving: LivingSegementedTab = .livingInfo) {
            self.selectedTab = selectedTab
            self.category = .init(
                routes: [.root(.category(.init(selectedCategory: selectedCategory)))]
            )
            self.living = .init(
                routes: [.root(.living(.init(selectedLiving: selectedLiving)))]
            )
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
                if tab == .home {
                    return .run { send in
                        await send(.home(.routeAction(0, action: .home(.onAppear))))
                    }
                }
            default:
                return .none
            }

            return .none
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
