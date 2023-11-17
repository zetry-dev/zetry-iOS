//
//  HomeClient.swift
//  HomeDomainInterface
//
//  Created by Allie Kim on 2023/11/09.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
import ComposableArchitecture

public struct HomeClient {
    public var fetchMainBannerItems: @Sendable () async throws -> [BannerEntity]

    public init(
        fetchMainBannerItems: @Sendable @escaping () async throws -> [BannerEntity]
    ) {
        self.fetchMainBannerItems = fetchMainBannerItems
    }
}

extension HomeClient: TestDependencyKey {
    public static let previewValue = Self(
        fetchMainBannerItems: { [] }
    )

    public static let testValue = Self(
        fetchMainBannerItems: unimplemented("\(Self.self).home.fetchMainBannerItems")
    )
}
