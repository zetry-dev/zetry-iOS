//
//  ProductClient.swift
//  ProductDomain
//
//  Created by AllieKim on 2023/09/07.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
import ComposableArchitecture
import Networking

public extension DependencyValues {
    var productClient: ProductClient {
        get { self[ProductClient.self] }
        set { self[ProductClient.self] = newValue }
    }
}

extension ProductClient: DependencyKey {
    public static var liveValue = Self(
        fetchAllItems: {
            let data = try await FirestoreProvider.shared.fetch(ProductAPI.fetchAllItems)
            return data.compactMap { $0.mapping(ProductEntity.self) }
        },
        fetchItems: {
            let data = try await FirestoreProvider.shared.fetch(ProductAPI.fetchItems(category: $0))
            return data.compactMap { $0.mapping(ProductEntity.self) }
        },
        searchItems: {
            let data = try await FirestoreProvider.shared.fetch(ProductAPI.search(keyword: $0))
            return data.compactMap { $0.mapping(ProductEntity.self) }
        }
    )
}
