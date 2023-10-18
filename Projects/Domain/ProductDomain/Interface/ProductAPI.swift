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
}

extension ProductAPI: TargetType {
    public var endPoint: EndPoint {
        .products
    }

    public var query: [String: Any]? {
        switch self {
        case .fetchItems(let category):
            return ["category": category]
        default:
            return nil
        }
    }

    public var path: String? {
        nil
    }
}
