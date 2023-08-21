//
//  HomeCoordinator.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import Combine
import ComposableArchitecture
import TCACoordinators

public struct HomeCoordinator: Reducer {
    public init() {}

    public struct State: Equatable, IndexedRouterState {
        public var routes: [Route<HomeScreen.State>]

        public init(routes: [Route<HomeScreen.State>] = [.root(.home(.init()), embedInNavigationView: true)]) {
            self.routes = routes
        }
    }

    public enum Action: IndexedRouterAction {
        case updateRoutes([Route<HomeScreen.State>])
        case routeAction(Int, action: HomeScreen.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
