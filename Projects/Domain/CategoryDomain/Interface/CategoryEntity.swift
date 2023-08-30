//
//  CategoryEntity.swift
//  CategoryDomainInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public struct CategoryItemEntity: Decodable, Equatable {
    public var title: String
    public var category: String
    public var image: String?
    public var recyclable: Bool?
}

public extension [CategoryItemEntity] {
    static var mock = [
        CategoryItemEntity(title: "종이컵", category: "종이", image: "imageURL", recyclable: true),
        CategoryItemEntity(title: "우산", category: "비닐", image: "imageURL", recyclable: true),
        CategoryItemEntity(title: "선풍기", category: "플라스틱", image: "imageURL", recyclable: true),
        CategoryItemEntity(title: "유리컵", category: "유리", image: "imageURL", recyclable: true),
        CategoryItemEntity(title: "뽁뽁이", category: "비닐", image: "imageURL", recyclable: true)
    ]
}
