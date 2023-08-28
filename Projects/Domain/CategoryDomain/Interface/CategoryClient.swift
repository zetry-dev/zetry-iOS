//
//  CategoryClient.swift
//  CategoryDomainInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture

public struct CategoryClient {
    public var fetchMain: @Sendable () async throws -> CategoryEntity
    public var fetchSub: @Sendable () async throws -> CategoryEntity

    public init(
        fetchMain: @Sendable @escaping () async throws -> CategoryEntity,
        fetchSub: @Sendable @escaping () async throws -> CategoryEntity
    ) {
        self.fetchMain = fetchMain
        self.fetchSub = fetchSub
    }
}

extension CategoryClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchMain: { .mock },
        fetchSub: { .mock }
    )

    public static let testValue = Self(
        fetchMain: unimplemented("\(Self.self).category.main"),
        fetchSub: unimplemented("\(Self.self).category.sub")
    )
}
