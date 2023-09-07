//
//  ProductClient.swift
//  ProductDomainInterface
//
//  Created by AllieKim on 2023/09/07.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture

public struct ProductClient {
    public var fetchAllItems: @Sendable () async throws -> [ProductEntity]
    public var fetchItems: @Sendable (_ category: String) async throws -> [ProductEntity]

    public init(
        fetchAllItems: @Sendable @escaping () async throws -> [ProductEntity],
        fetchItems: @Sendable @escaping (_ category: String) async throws -> [ProductEntity]
    ) {
        self.fetchAllItems = fetchAllItems
        self.fetchItems = fetchItems
    }
}

extension ProductClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchAllItems: { .mock },
        fetchItems: { _ in .mock }
    )

    public static let testValue = Self(
        fetchAllItems: unimplemented("\(Self.self).product.fetchAllItems"),
        fetchItems: unimplemented("\(Self.self).product.fetchItems")
    )
}
