//
//  ZentryColorSystem+Primary.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public extension Color.ZentryColorSystem {
    enum Primary: ZentryColorable {
        case primary
    }
}

public extension Color.ZentryColorSystem.Primary {
    var color: Color {
        switch self {
        case .primary: return DesignSystemAsset.System.primary.swiftUIColor
        }
    }
}
