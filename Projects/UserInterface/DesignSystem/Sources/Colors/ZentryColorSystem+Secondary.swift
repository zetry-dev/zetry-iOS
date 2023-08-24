//
//  ZentryColorSystem+Secondary.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public extension Color.ZentryColorSystem {
    enum Secondary: ZentryColorable {
        case secondary
    }
}

public extension Color.ZentryColorSystem.Secondary {
    var color: Color {
        switch self {
        case .secondary: return DesignSystemAsset.System.secondary.swiftUIColor
        }
    }

    var uiColor: UIColor {
        switch self {
        case .secondary: return DesignSystemAsset.System.secondary.color
        }
    }
}
