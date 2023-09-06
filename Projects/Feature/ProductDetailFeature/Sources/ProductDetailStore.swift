//
//  ProductDetailReducer.swift
//  ProductDetailFeature
//
//  Created by AllieKim on 2023/08/29.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CategoryDomain
import CategoryDomainInterface
import ComposableArchitecture

public struct ProductDetailStore: Reducer {
    public init() {}

    public struct State: Equatable {
        let item: CategoryItemEntity

        public init(item: CategoryItemEntity) {
            self.item = item
        }
    }

    public enum Action: Equatable {
        case onAppear
//        case dataLoaded(TaskResult<CategoryItemEntity>)
    }

    @Dependency(\.categoryClient) var categoryClient

    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .onAppear:
//                dump(state.item)
                return .none
            default: return .none
            }
        }
    }
}
