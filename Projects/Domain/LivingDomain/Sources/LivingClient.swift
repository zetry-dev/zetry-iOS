//
//  LivingClient.swift
//  LivingDomain
//
//  Created by AllieKim on 2023/10/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
import ComposableArchitecture
import LivingDomainInterface
import Networking

public extension DependencyValues {
    var livingClient: LivingClient {
        get { self[LivingClient.self] }
        set { self[LivingClient.self] = newValue }
    }
}

extension LivingClient: DependencyKey {
    public static var liveValue = Self(
        fetchLivingItems: { livingType in
            let data = try await FirestoreProvider.shared.fetch(LivingAPI.fetchLivingItems(type: livingType))
            return data.compactMap { $0.mapping(LivingEntity.self) }
        }
    )
}
