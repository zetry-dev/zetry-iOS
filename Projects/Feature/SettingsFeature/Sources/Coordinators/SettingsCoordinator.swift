//
//  SettingsCoordinator.swift
//  SettingsFeature
//
//  Created by AllieKim on 2023/08/31.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import TCACoordinators

public struct SettingsCoordinator: Reducer {
    public init() {}

    public struct State: Equatable, IndexedRouterState {
        public var routes: [Route<SettingsScreen.State>]

        public init(routes: [Route<SettingsScreen.State>] = [.root(.settings(.init()), embedInNavigationView: true)]) {
            self.routes = routes
        }
    }

    public enum Action: IndexedRouterAction {
        case updateRoutes([Route<SettingsScreen.State>])
        case routeAction(Int, action: SettingsScreen.Action)
    }

    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
        .forEachRoute {
            SettingsScreen()
        }
    }
}
