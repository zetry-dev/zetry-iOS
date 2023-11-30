//
//  Font+DesignSystem.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public extension Font {
    enum ZetryFontSystem {
        case headline1
        case headline2
        case headline3
        case subtitle1
        case subtitle2
        case subtitle3
        case subtitle4
        case subtitle5
        case boldSubtitle1
        case body1
        case body2
        case body3
        case body4
        case body5
        case label1
        case label2
        case label3
        case label4
        case label5
    }

    static func zetry(_ style: ZetryFontSystem) -> Font {
        style.font
    }

    static func zetry(_ style: ZetryFontSystem) -> UIFont {
        style.uiFont
    }
}
