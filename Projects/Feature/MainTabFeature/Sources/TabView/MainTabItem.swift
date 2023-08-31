//
//  MainTabItem.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import DesignSystem
import Foundation

public enum MainTabItem {
    case home
    case category
    case living
    case settings

    var description: String {
        switch self {
        case .home:
            return "홈"
        case .category:
            return "카테고리"
        case .living:
            return "생활정보"
        case .settings:
            return "설정"
        }
    }

    var icon: DesignSystemImages {
        switch self {
        case .home:
            return DesignSystemAsset.Icons.house
        case .category:
            return DesignSystemAsset.Icons.line3Magnifyingglass
        case .living:
            return DesignSystemAsset.Icons.magazine
        case .settings:
            return DesignSystemAsset.Icons.gearshape
        }
    }
}
