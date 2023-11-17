//
//  LivingEntity.swift
//  LivingDomain
//
//  Created by AllieKim on 2023/10/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import Foundation

public struct LivingEntity: Decodable, Hashable {
    public let title: String
    public let subtitle: String
    public let imageURL: String
    public let linkURL: String

    public init() {
        title = "친환경 물품을 소개합니다."
        subtitle = "요즘 트렌드로 떠오르는 친환경 물품에 대해 간단하게 설명해드릴게요."
        imageURL = "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
        linkURL = ""
    }
}
