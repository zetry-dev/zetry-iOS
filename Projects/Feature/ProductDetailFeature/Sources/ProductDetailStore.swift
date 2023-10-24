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
        let imageHeight: CGFloat = UIScreen.main.bounds.height / 2.2
        var scrollViewOffsetY: CGFloat = 0.0

        public init(item: ProductEntity) {
            self.item = item
        }
    }

    public enum Action: Equatable {
        case onLoad
        case scrollOffsetYChanged(CGFloat)

        case pop
        case popToRoot
    }

    @Dependency(\.productClient) var productClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onLoad:
                return .none
            case .scrollOffsetYChanged(let offset):
                state.scrollViewOffsetY = offset
                return .none
            default:
                return .none
            }
        }
    }
}
