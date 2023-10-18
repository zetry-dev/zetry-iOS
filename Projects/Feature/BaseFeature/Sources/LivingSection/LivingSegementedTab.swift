//
//  LivingSection.swift
//  BaseFeature
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CoreKitInterface
import SwiftUI

public enum LivingSegementedTab: Int, Segments, CaseIterable, Equatable {
    case home = 0
    case livingInfo
    case today
    case tips

    public static var allCases: [LivingSegementedTab] {
        [.livingInfo, .today, .tips]
    }

    public var title: String {
        switch self {
        case .livingInfo: return "생활정보"
        case .today: return "오늘의 추천상점"
        case .tips: return "알면 좋은 꿀팁"
        default: return ""
        }
    }
    
    public var path: String {
        switch self {
        case .livingInfo: return "information"
        case .today: return "today"
        case .tips: return "tips"
        default: return ""
        }
    }
}
