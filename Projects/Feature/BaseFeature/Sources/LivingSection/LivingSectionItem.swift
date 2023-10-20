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
    var bannerSection: LivingEntity?
    var scrollSection: [LivingEntity]

    public init() {
        listSection = []
        bannerSection = nil
        scrollSection = []
    }

    public init(listSection: [LivingEntity], bannerSection: LivingEntity?, scrollSection: [LivingEntity]) {
        self.listSection = listSection
        self.bannerSection = bannerSection
        self.scrollSection = scrollSection
    }
}
