//
//  ProductEntity.swift
//  ProductDomainInterface
//
//  Created by AllieKim on 2023/09/07.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public struct ProductEntity: Decodable, Equatable {
    public var title: String
    public var category: String
    public var image: String?
    public var recyclable: Bool?
}

public extension ProductEntity {
    static var mock = ProductEntity(title: "종이컵", category: "종이", image: "imageURL", recyclable: true)
}

public extension [ProductEntity] {
    static var mock = [
        ProductEntity(title: "종이컵", category: "종이", image: "imageURL", recyclable: true),
        ProductEntity(title: "박스", category: "종이", image: "imageURL", recyclable: true),
        ProductEntity(title: "신문지", category: "종이", image: "imageURL", recyclable: true),
        ProductEntity(title: "한지", category: "종이", image: "imageURL", recyclable: true),
        ProductEntity(title: "포장지", category: "종이", image: "imageURL", recyclable: true)
    ]
}
