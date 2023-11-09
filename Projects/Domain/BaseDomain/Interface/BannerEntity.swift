//
//  BannerEntity.swift
//  BaseDomainInterface
//
//  Created by Allie Kim on 2023/11/09.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CoreKitInterface
import Foundation

public struct BannerEntity: Decodable, Banner {
    public let title: String
    public let subtitle: String
    public let imageURL: String
    public let linkURL: String
    public let priority: Int

    public init() {
        title = ""
        subtitle = ""
        imageURL = ""
        linkURL = ""
        priority = 0
    }
}

extension BannerEntity: Comparable {
    public static func < (lhs: BannerEntity, rhs: BannerEntity) -> Bool {
        lhs.priority < rhs.priority
    }
}
