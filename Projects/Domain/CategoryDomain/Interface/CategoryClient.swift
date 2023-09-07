//
//  CategoryClient.swift
//  CategoryDomainInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture

public struct CategoryClient {
    public var fetchCategories: @Sendable () async throws -> [CategoryEntity]

    public init(
        fetchCategories: @Sendable @escaping () async throws -> [CategoryEntity]
    ) {
        self.fetchCategories = fetchCategories
    }
}

extension CategoryClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchCategories: { .mock }
    )

    public static let testValue = Self(
        fetchCategories: unimplemented("\(Self.self).category.fetchCategories")
    )
}
