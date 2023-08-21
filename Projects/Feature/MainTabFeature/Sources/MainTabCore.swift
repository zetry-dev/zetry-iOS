//
//  MainTabCore.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import CategoryFeature
import ComposableArchitecture
import HomeFeature
import LivingFeature

public struct MainTabCore: Reducer {
    public init() {}

    public struct State: Equatable {
        public var selectedTab: MainTabItem = .home

        public var home: HomeStore.State = .init()
        public var category: CategoryReducer.State = .init()
        public var living: LivingReducer.State = .init()

        public init() {}
    }

    public enum Action: Equatable {
        case tabSelected(MainTabItem)
        case home(HomeStore.Action)
        case category(CategoryReducer.Action)
        case living(LivingReducer.Action)
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
            HomeStore()._printChanges()
        })

        Scope(state: \.category, action: /Action.category, child: {
            CategoryReducer()._printChanges()
        })

        Scope(state: \.living, action: /Action.living, child: {
            LivingReducer()._printChanges()
        })
    }
}
