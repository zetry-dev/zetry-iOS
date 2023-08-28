//
//  CategoryEntity.swift
//  CategoryDomainInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public struct CategoryEntity: Decodable, Equatable {
    public var items: [CategoryItemEntity]

    public init() {
        items = []
    }

    public init(items: [CategoryItemEntity]) {
        self.items = items
    }
}

public struct CategoryItemEntity: Decodable, Equatable {
    public var title: String
}

public extension CategoryEntity {
    static var mock = Self(
        items: [
            CategoryItemEntity(title: "종이컵"),
            CategoryItemEntity(title: "우산"),
            CategoryItemEntity(title: "선풍기"),
            CategoryItemEntity(title: "유리컵"),
            CategoryItemEntity(title: "뽁뽁이")
        ]
    )
}
