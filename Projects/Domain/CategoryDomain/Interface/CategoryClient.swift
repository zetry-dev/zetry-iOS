//
//  CategoryClient.swift
//  CategoryDomainInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface

public struct CategoryClient {
    public var fetchAllItems: @Sendable () async throws -> [CategoryItemEntity]
    public var fetchItems: @Sendable (_ category: String) async throws -> [CategoryItemEntity]

    public init(
        fetchAllItems: @Sendable @escaping () async throws -> [CategoryItemEntity],
        fetchItems: @Sendable @escaping (_ category: String) async throws -> [CategoryItemEntity]
    ) {
        self.fetchAllItems = fetchAllItems
        self.fetchItems = fetchItems
    }
}

extension CategoryClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchAllItems: { .mock },
        fetchItems: { _ in .mock }
    )

    public static let testValue = Self(
        fetchAllItems: unimplemented("\(Self.self).category.main"),
        fetchItems: unimplemented("\(Self.self).category.sub")
    )
}
