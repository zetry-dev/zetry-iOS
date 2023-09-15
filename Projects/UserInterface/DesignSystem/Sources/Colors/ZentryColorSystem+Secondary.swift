//
//  ZetryColorSystem+Secondary.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension Color.ZetryColorSystem {
    enum Secondary: ZetryColorable {
        case secondary
        case secondary8
    }
}

public extension Color.ZetryColorSystem.Secondary {
    var color: Color {
        switch self {
        case .secondary: return DesignSystemAsset.System.secondary.swiftUIColor
        case .secondary8: return DesignSystemAsset.System.secondary8.swiftUIColor
        }
    }

    var uiColor: UIColor {
        switch self {
        case .secondary: return DesignSystemAsset.System.secondary.color
        case .secondary8: return DesignSystemAsset.System.secondary8.color
        }
    }
}
