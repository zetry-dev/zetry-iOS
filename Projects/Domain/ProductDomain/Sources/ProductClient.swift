//
//  ProductClient.swift
//  ProductDomain
//
//  Created by AllieKim on 2023/09/07.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture

public struct ProductClient {
    public var fetchAllItems: @Sendable () async throws -> [ProductEntity]
    public var fetchItems: @Sendable (_ category: String) async throws -> [ProductEntity]
    public var searchItems: @Sendable (_ keyword: String) async throws -> [ProductEntity]

    public init(
        fetchAllItems: @Sendable @escaping () async throws -> [ProductEntity],
        fetchItems: @Sendable @escaping (_ category: String) async throws -> [ProductEntity],
        searchItems: @Sendable @escaping (_ keyword: String) async throws -> [ProductEntity]
    ) {
        self.fetchAllItems = fetchAllItems
        self.fetchItems = fetchItems
        self.searchItems = searchItems
    }
}

extension ProductClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchAllItems: { .mock },
        fetchItems: { _ in .mock },
        searchItems: { _ in .mock }
    )

    public static let testValue = Self(
        fetchAllItems: unimplemented("\(Self.self).product.fetchAllItems"),
        fetchItems: unimplemented("\(Self.self).product.fetchItems"),
        searchItems: unimplemented("\(Self.self).product.searchItems")
    )
}
