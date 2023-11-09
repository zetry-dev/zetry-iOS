//
//  HomeClient.swift
//  HomeDomainInterface
//
//  Created by Allie Kim on 2023/11/09.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
import ComposableArchitecture
import HomeDomainInterface
import Networking

public extension DependencyValues {
    var homeClient: HomeClient {
        get { self[HomeClient.self] }
        set { self[HomeClient.self] = newValue }
    }
}

extension HomeClient: DependencyKey {
    public static var liveValue = Self(
        fetchMainBannerItems: {
            let data = try await FirestoreProvider.shared.fetch(HomeAPI.fetchMainBannerItems)
            return data.compactMap { $0.mapping(BannerEntity.self) }
        }
    )
}
