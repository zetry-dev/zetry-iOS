//
//  ZetryColorSystem+Primary.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension Color.ZetryColorSystem {
    enum Primary: ZetryColorable {
        case primary
        case primary0
        case background
        case white
        case black
    }
}

public extension Color.ZetryColorSystem.Primary {
    var color: Color {
        switch self {
        case .primary: return DesignSystemAsset.System.primary.swiftUIColor
        case .primary0: return DesignSystemAsset.System.primary0.swiftUIColor
        case .background: return DesignSystemAsset.System.background.swiftUIColor
        case .white: return .white
        case .black: return .black
        }
    }

    var uiColor: UIColor {
        switch self {
        case .primary: return DesignSystemAsset.System.primary.color
        case .primary0: return DesignSystemAsset.System.primary0.color
        case .background: return DesignSystemAsset.System.background.color
        case .white: return .white
        case .black: return .black
        }
    }
}
