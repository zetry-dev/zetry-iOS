//
//  TestClient.swift
//  CategoryDomain
//
//  Created by Allie Kim on 2023/08/27.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
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
        fetchCategories: {
            let data = try await FirestoreProvider.shared.fetch(CategoryAPI.fetchCategories)
            return data.compactMap { $0.mapping(CategoryEntity.self) }
        }
    )
}
