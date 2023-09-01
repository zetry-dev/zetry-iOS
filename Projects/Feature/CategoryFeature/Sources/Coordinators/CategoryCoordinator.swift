//
//  CategoryCoordinator.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface

public struct CategoryCoordinator: Reducer {
    public init() {}

    public struct State: Equatable, IndexedRouterState {
        public var routes: [Route<CategoryScreen.State>]

        public init(routes: [Route<CategoryScreen.State>] = [.root(.category(.init()), embedInNavigationView: true)]) {
            self.routes = routes
        }
    }

    public enum Action: BindableAction, IndexedRouterAction {
        case binding(BindingAction<State>)
        case updateRoutes([Route<CategoryScreen.State>])
        case routeAction(Int, action: CategoryScreen.Action)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
        .forEachRoute {
            CategoryScreen()
        }
    }
}
