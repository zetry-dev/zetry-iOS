//
//  ProductEntity.swift
//  ProductDomainInterface
//
//  Created by AllieKim on 2023/09/07.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public struct ProductEntity: Decodable, Equatable, Hashable {
    public let title: String
    public let category: String
    public let imageURL: String
    public let recyclable: Bool
    public let isTrash: Bool
    public let description: [String]
    public let keywords: [String]
}

public extension ProductEntity {
    static var mock = ProductEntity(
        title: "종이컵",
        category: "종이",
        imageURL: "imageURL",
        recyclable: true,
        isTrash: false,
        description: ["종이컵버리는법"],
        keywords: ["종이"]
    )
}

public extension [ProductEntity] {
    static var mock = [
        ProductEntity(
            title: "종이컵",
            category: "종이",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"]
        ),
        ProductEntity(
            title: "박스",
            category: "종이류",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"]
        ),
        ProductEntity(
            title: "신문지",
            category: "종이류",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"]
        ),
        ProductEntity(
            title: "한지",
            category: "종이류",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"]
        ),
        ProductEntity(
            title: "포장지",
            category: "종이류",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"]
        )
    ]
}
