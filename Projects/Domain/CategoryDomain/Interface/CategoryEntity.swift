//
//  CategoryEntity.swift
//  CategoryDomainInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public struct CategoryEntity: Decodable, Equatable {
    public var title: String
    public var imageURL: String
    public var priority: Int

    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image"
        case priority
    }

    public init(title: String, image: String, priority: Int) {
        self.title = title
        self.imageURL = image
        self.priority = priority
    }

    public init() {
        self.title = ""
        self.imageURL = ""
        self.priority = -1
    }
}

extension CategoryEntity: Comparable {
    public static func < (lhs: CategoryEntity, rhs: CategoryEntity) -> Bool {
        lhs.priority < rhs.priority
    }
}

public extension [CategoryEntity] {
    static var mock = [
        CategoryEntity(title: "종이류", image: "imageURL", priority: 0),
        CategoryEntity(title: "비닐류", image: "imageURL", priority: 1),
        CategoryEntity(title: "의류", image: "imageURL", priority: 2),
        CategoryEntity(title: "캔/고철류", image: "imageURL", priority: 3),
        CategoryEntity(title: "스티로폼류", image: "imageURL", priority: 4)
    ]
}
