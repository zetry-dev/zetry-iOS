//
//  Color+DesignSystem.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

protocol ZentryColorable {
    var color: Color { get }
}

public extension Color {
    enum ZentryColorSystem {
        case primary(Primary)
        case secondary(Secondary)
        case grayScale(GrayScale)
        case background(Background)
    }

    static func zentry(_ style: ZentryColorSystem) -> Color {
        switch style {
        case let .primary(colorable as ZentryColorable),
             let .secondary(colorable as ZentryColorable),
             let .grayScale(colorable as ZentryColorable),
             let .background(colorable as ZentryColorable):
            return colorable.color
        }
    }
}
