//
//  ProductDetailReducer.swift
//  ProductDetailFeature
//
//  Created by AllieKim on 2023/08/29.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import ProductDomain
import ProductDomainInterface

public struct ProductDetailStore: Reducer {
    public init() {}

    public struct State: Equatable {
        let item: ProductEntity

        public init(item: ProductEntity) {
            self.item = item
        }
    }

    public enum Action: Equatable {
        case onAppear
    }

    @Dependency(\.productClient) var productClient

    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .onAppear:
                return .none
            default: return .none
            }
        }
    }
}
