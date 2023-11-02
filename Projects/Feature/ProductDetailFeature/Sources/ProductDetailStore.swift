//
//  ProductDetailReducer.swift
//  ProductDetailFeature
//
//  Created by AllieKim on 2023/08/29.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import Foundation
import ProductDomain
import ProductDomainInterface
import UIKit

public struct ProductDetailStore: Reducer {
    public init() {}

    public struct State: Equatable {
        let item: ProductEntity
        var recommendedItems: [ProductEntity] = []
        let imageHeight: CGFloat = UIScreen.main.bounds.height / 2.2
        var scrollViewOffsetY: CGFloat = 0.0

        public init(item: ProductEntity) {
            self.item = item
        }
    }

    public enum Action: Equatable {
        case onLoad
        case scrollOffsetYChanged(CGFloat)

        case fetchProduct
        case productDataLoaded(TaskResult<[ProductEntity]>)

        case pop
        case popToRoot
    }

    @Dependency(\.productClient) var productClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onLoad:
                return .send(.fetchProduct)
            case let .scrollOffsetYChanged(offset):
                state.scrollViewOffsetY = offset
                return .none
            case .fetchProduct:
                return .run { send in
                    let result = await TaskResult {
                        try await productClient.fetchAllItems()
                    }
                    await send(.productDataLoaded(result))
                }
            case let .productDataLoaded(.success(result)):
                state.recommendedItems = Array(result.shuffled().prefix(4))
                return .none
            default:
                return .none
            }
        }
    }
}
