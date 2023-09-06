//
//  HomeStore.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import TCACoordinators

public struct HomeStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var categories: [ZetryCategory] = ZetryCategory.allCases
        var isAnimated: Bool = false

        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
        case routeToSearch
        case routeToLiving
        case animatingList
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .animatingList:
                state.isAnimated = true
                return .none
            default: return .none
            }
        }
    }
}
