//
//  MainTabReducer.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import CategoryFeature
import ComposableArchitecture
import HomeFeature
import LivingFeature

public struct MainTabReducer: Reducer {
    public init() {}

    public struct State: Equatable {
        public var selectedTab: MainTabItem = .home

        public var home: HomeReducer.State = .init()
        public var category: CategoryReducer.State = .init()
        public var living: LivingReducer.State = .init()

        public init() {}
    }

    public enum Action: Equatable {
        case tabSelected(MainTabItem)
        case home(HomeReducer.Action)
        case category(CategoryReducer.Action)
        case living(LivingReducer.Action)
    }

    public var body: some Reducer<State, Action> {
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
            HomeReducer()._printChanges()
        })

        Scope(state: \.category, action: /Action.category, child: {
            CategoryReducer()._printChanges()
        })

        Scope(state: \.living, action: /Action.living, child: {
            LivingReducer()._printChanges()
        })
    }
}
