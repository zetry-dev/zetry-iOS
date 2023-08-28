//
//  TestClient.swift
//  CategoryDomain
//
//  Created by Allie Kim on 2023/08/27.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomain
import CategoryDomainInterface
import ComposableArchitecture
import Networking

public extension DependencyValues {
    var categoryClient: CategoryClient {
        get { self[CategoryClient.self] }
        set { self[CategoryClient.self] = newValue }
    }
}

extension CategoryClient: DependencyKey {
    public static var liveValue = Self(
        fetchMain: {
            let data = try await FirestoreProvider.shared.fetch(CategoryAPI.fetchMain)
            return data.map(CategoryEntity.self, dictionary: data) ?? .init()
        },
        fetchSub: {
            let data = try await FirestoreProvider.shared.fetch(CategoryAPI.fetchSub)
            return data.map(CategoryEntity.self, dictionary: data) ?? .init()
        }
    )
}
