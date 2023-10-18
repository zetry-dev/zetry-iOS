//
//  LivingAPI.swift
//  LivingDomain
//
//  Created by AllieKim on 2023/10/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import NetworkingInterface

public enum LivingAPI {
    case fetchLivingItems(type: String)
}

extension LivingAPI: TargetType {
    public var path: String? {
        switch self {
        case .fetchLivingItems(let type):
            return "\(type)/items"
        }
    }

    public var endPoint: EndPoint {
        .living
    }

    public var query: [String: Any]? {
        switch self {
        case .fetchLivingItems(let livingType):
            return ["livingType": livingType]
        }
    }
}
