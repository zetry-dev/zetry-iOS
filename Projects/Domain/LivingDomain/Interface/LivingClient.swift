//
//  LivingClient.swift
//  LivingDomain
//
//  Created by AllieKim on 2023/10/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
import ComposableArchitecture

public struct LivingClient {
    public var fetchLivingItems: @Sendable (_ livingType: String) async throws -> [LivingEntity]
    public var fetchLivingBannerItems: @Sendable () async throws -> [BannerEntity]

    public init(
        fetchLivingItems: @Sendable @escaping (_ livingType: String) async throws -> [LivingEntity],
        fetchLivingBannerItems: @Sendable @escaping () async throws -> [BannerEntity]
    ) {
        self.fetchLivingItems = fetchLivingItems
        self.fetchLivingBannerItems = fetchLivingBannerItems
    }
}

extension LivingClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchLivingItems: { _ in [] },
        fetchLivingBannerItems: { [] }
    )

    public static let testValue = Self(
        fetchLivingItems: unimplemented("\(Self.self).living.fetchLivingItems"),
        fetchLivingBannerItems: unimplemented("\(Self.self).living.fetchLivingBannerItems")
    )
}
