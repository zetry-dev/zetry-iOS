//
//  ProductAPI.swift
//  ProductDomainInterface
//
//  Created by AllieKim on 2023/09/07.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import NetworkingInterface

public enum ProductAPI {
    case fetchItems(category: String)
    case fetchAllItems
    case search(keyword: String)
}

extension ProductAPI: TargetType {
    public var endPoint: EndPoint {
        .products
    }

    public var query: (field: String, value: Any)? {
        switch self {
        case .fetchItems(let category):
            return (field: "category", value: category)
        case .search(let keyword):
            return (field: "keywords", value: keyword)
        default:
            return nil
        }
    }

    public var path: String? {
        nil
    }
}
