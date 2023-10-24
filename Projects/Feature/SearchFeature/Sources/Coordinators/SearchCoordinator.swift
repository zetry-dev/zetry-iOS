//
//  SearchCoordinator.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/23.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import TCACoordinators

public struct SearchCoordinator: Reducer {
    public init() {}

    public struct State: Equatable, IndexedRouterState {
        public var routes: [Route<SearchScreen.State>]
    }

    public enum Action: BindableAction, IndexedRouterAction {
        case binding(BindingAction<State>)
        case updateRoutes([Route<SearchScreen.State>])
        case routeAction(Int, action: SearchScreen.Action)
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
            SearchScreen()
        }
    }
}
