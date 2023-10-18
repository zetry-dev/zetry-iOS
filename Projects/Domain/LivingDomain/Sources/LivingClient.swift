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
    var productClient: LivingClient {
        get { self[LivingClient.self] }
        set { self[LivingClient.self] = newValue }
    }
}

extension LivingClient: DependencyKey {
    public static var liveValue = Self(
        fetchLivingItems: { _ in [] }
    )
}
