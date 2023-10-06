//
//  Color+DesignSystem.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

protocol ZetryColorable {
    var color: Color { get }
    var uiColor: UIColor { get }
}

public extension Color {
    enum ZetryColorSystem {
        case primary(Primary)
        case secondary(Secondary)
        case grayScale(GrayScale)
    }

    static func zetry(_ style: ZetryColorSystem) -> Color {
        switch style {
        case let .primary(colorable as ZetryColorable),
             let .secondary(colorable as ZetryColorable),
             let .grayScale(colorable as ZetryColorable):
            return colorable.color
        }
    }

    static func zetry(_ style: ZetryColorSystem) -> UIColor {
        switch style {
        case let .primary(colorable as ZetryColorable),
             let .secondary(colorable as ZetryColorable),
             let .grayScale(colorable as ZetryColorable):
            return colorable.uiColor
        }
    }
}
