//
//  ProductEntity.swift
//  ProductDomain
//
//  Created by AllieKim on 2023/09/07.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public struct ProductEntity: Decodable, Equatable, Hashable, Sendable {
    public let title: String
    public let category: String
    public let categoryImageURL: String
    public let imageURL: String
    public let recyclable: Bool
    public let isTrash: Bool
    public let description: [String]
    public var keywords: [String]? = nil
    public var notice: String? = nil

    enum CodingKeys: CodingKey {
        case title, category, categoryImageURL, imageURL, recyclable, isTrash, description, keywords, notice
    }

    init(title: String, category: String, categoryImageURL: String, imageURL: String, recyclable: Bool, isTrash: Bool, description: [String], keywords: [String]? = nil, notice: String? = nil) {
        self.title = title
        self.category = category
        self.categoryImageURL = categoryImageURL
        self.imageURL = imageURL
        self.recyclable = recyclable
        self.isTrash = isTrash
        self.description = description
        self.keywords = keywords
        self.notice = notice
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.category = try container.decode(String.self, forKey: .category)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
        self.recyclable = try container.decode(Bool.self, forKey: .recyclable)
        self.isTrash = try container.decode(Bool.self, forKey: .isTrash)
        self.description = try container.decode([String].self, forKey: .description)
        self.keywords = try container.decodeIfPresent([String].self, forKey: .keywords)
        self.notice = try container.decodeIfPresent(String.self, forKey: .notice)
        self.categoryImageURL = try container.decodeIfPresent(String.self, forKey: .categoryImageURL) ?? ""
    }
}

public extension ProductEntity {
    static var mock = ProductEntity(
        title: "종이컵",
        category: "종이",
        categoryImageURL: "categoryImageURL",
        imageURL: "imageURL",
        recyclable: true,
        isTrash: false,
        description: ["종이컵버리는법"],
        keywords: ["종이"],
        notice: nil
    )
}

public extension [ProductEntity] {
    static var mock = [
        ProductEntity(
            title: "종이컵",
            category: "종이",
            categoryImageURL: "categoryImageURL",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"],
            notice: nil
        ),
        ProductEntity(
            title: "박스",
            category: "종이류",
            categoryImageURL: "categoryImageURL",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"],
            notice: nil
        ),
        ProductEntity(
            title: "신문지",
            category: "종이류",
            categoryImageURL: "categoryImageURL",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"],
            notice: nil
        ),
        ProductEntity(
            title: "한지",
            category: "종이류",
            categoryImageURL: "categoryImageURL",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"],
            notice: nil
        ),
        ProductEntity(
            title: "포장지",
            category: "종이류",
            categoryImageURL: "categoryImageURL",
            imageURL: "imageURL",
            recyclable: true,
            isTrash: false,
            description: ["종이컵버리는법"],
            keywords: ["종이"],
            notice: nil
        )
    ]
}
