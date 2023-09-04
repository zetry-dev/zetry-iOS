//
//  HomeStore.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import BaseFeatureInterface

public struct HomeStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var categories: [ZetryCategory]
        
        public init() {
            categories = Array(ZetryCategory.allCases.prefix(9))
            categories.append(.empty)
        }
    }

    public enum Action: Equatable {
        case onAppear
        case routeToSearch
        case routeToLiving
        case unfoldCategories
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .unfoldCategories:
                state.categories = ZetryCategory.allCases
                return .none
            default: return .none
            }
        }
    }
}
