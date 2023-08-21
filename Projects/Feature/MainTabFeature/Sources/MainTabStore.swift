//
//  MainTabStore.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import CategoryFeature
import ComposableArchitecture
import HomeFeature
import LivingFeature

public struct MainTabStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public var selectedTab: MainTabItem = .home

        public var home: HomeCoordinator.State = .init()
        public var category: CategoryCoordinator.State = .init()
        public var living: LivingCoordinator.State = .init()

        public init() {}
    }

    public enum Action {
        case tabSelected(MainTabItem)
        case home(HomeCoordinator.Action)
        case category(CategoryCoordinator.Action)
        case living(LivingCoordinator.Action)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tabSelected(let tab):
                state.selectedTab = tab
                return .none
//                if tab == .home {
//                    return Effect.send(.home(.routeAction(0, action: .home(.onAppear))))
//                } else if tab == .category {
//                    return Effect.send(.category(.routeAction(0, action: .category(.onAppear))))
//                } else {
//                    return Effect.send(.living(.routeAction(0, action: .living(.onAppear))))
//                }
            default:
                return .none
            }
        }

        Scope(state: \.home, action: /Action.home, child: {
            HomeCoordinator()._printChanges()
        })

        Scope(state: \.category, action: /Action.category, child: {
            CategoryCoordinator()._printChanges()
        })

        Scope(state: \.living, action: /Action.living, child: {
            LivingCoordinator()._printChanges()
        })
    }
}
