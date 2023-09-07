//
//  CategoryAPI.swift
//  CategoryDomainInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import NetworkingInterface

public enum CategoryAPI {
    case fetchCategories
}

extension CategoryAPI: TargetType {
    public var endPoint: EndPoint {
        .categories
    }

    public var query: [String: Any]? {
        nil
    }
}
