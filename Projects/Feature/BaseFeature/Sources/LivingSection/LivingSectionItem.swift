//
//  LivingSection.swift
//  BaseFeature
//
//  Created by AllieKim on 2023/10/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import LivingDomainInterface

public struct LivingSectionItem: Equatable, Hashable {
    var listSection: [LivingEntity]
    var bannerSection: LivingEntity
    var scrollSection: [LivingEntity]

    init() {
        listSection = Array(repeating: .init(), count: 2)
        bannerSection = .init()
        scrollSection = Array(repeating: .init(), count: 5)
    }
}
