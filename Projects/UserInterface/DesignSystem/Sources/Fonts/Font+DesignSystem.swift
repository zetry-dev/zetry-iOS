//
//  Font+DesignSystem.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public extension Font {
    enum ZentryFontSystem {
        case headline1
        case headline2
        case headline3
        case subtitle1
        case subtitle2
        case subtitle3
        case subtitle4
        case body1
        case body2
        case body3
        case body4
        case label1
        case label2
        case label3
        case label4
        case label5
    }

    static func zentry(_ style: ZentryFontSystem) -> Font {
        style.font
    }
}
