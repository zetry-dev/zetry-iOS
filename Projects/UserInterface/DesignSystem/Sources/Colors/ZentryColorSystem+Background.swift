//
//  ZentryColorSystem+Background.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public extension Color.ZentryColorSystem {
    enum Background: ZentryColorable {
        case background
    }
}

public extension Color.ZentryColorSystem.Background {
    var color: Color {
        switch self {
        default: return .white
        }
    }
}
