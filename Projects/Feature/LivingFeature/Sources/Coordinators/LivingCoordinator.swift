//
//  LivingCoordinator.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import Combine
import ComposableArchitecture
import TCACoordinators

public struct LivingCoordinator: Reducer {
    public init() {}

    public struct State: Equatable, IndexedRouterState {
        public var routes: [Route<LivingScreen.State>]

        public init(routes: [Route<LivingScreen.State>] = [.root(.living(.init()), embedInNavigationView: true)]) {
            self.routes = routes
        }
    }

    public enum Action: IndexedRouterAction {
        case updateRoutes([Route<LivingScreen.State>])
        case routeAction(Int, action: LivingScreen.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}