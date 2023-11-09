//
//  HomeAPI.swift
//  HomeDomainInterface
//
//  Created by Allie Kim on 2023/11/09.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import NetworkingInterface

public enum HomeAPI {
    case fetchMainBannerItems
}

extension HomeAPI: TargetType {
    public var endPoint: EndPoint {
        .mainBanners
    }

    public var query: (field: String, value: Any)? {
        nil
    }

    public var path: String? {
        nil
    }
}
