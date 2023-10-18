//
//  LivingClient.swift
//  LivingDomain
//
//  Created by AllieKim on 2023/10/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture

public struct LivingClient {
    public var fetchLivingItems: @Sendable (_ livingType: String) async throws -> [LivingEntity]

    public init(
        fetchLivingItems: @Sendable @escaping (_ livingType: String) async throws -> [LivingEntity]
    ) {
        self.fetchLivingItems = fetchLivingItems
    }
}

extension LivingClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchLivingItems: { _ in [] }
    )

    public static let testValue = Self(
        fetchLivingItems: unimplemented("\(Self.self).living.fetchLivingItems")
    )
}
