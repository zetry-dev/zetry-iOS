//
//  CategoryAPI.swift
//  CategoryDomainInterface
//
//  Created by AllieKim on 2023/08/28.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import NetworkingInterface

public enum CategoryAPI {
    case fetchMain
    case fetchSub
}

extension CategoryAPI: TargetType {
    public var endPoint: EndPoint {
        .products
    }

    public var document: String {
        switch self {
        case .fetchMain:
            return "mainCategory"
        case .fetchSub:
            return "subCategory"
        }
    }
}
