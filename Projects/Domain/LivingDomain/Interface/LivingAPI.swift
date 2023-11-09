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
    case fetchLivingBannerItems
}

extension LivingAPI: TargetType {
    public var path: String? {
        switch self {
            case .fetchLivingItems(let type):
                return "/\(type)/items"
            case .fetchLivingBannerItems:
                return nil
        }
    }

    public var endPoint: EndPoint {
        switch self {
            case .fetchLivingBannerItems:
                return .livingBanners
            default:
                return .living
        }
    }

    public var query: (field: String, value: Any)? {
        nil
    }
}
