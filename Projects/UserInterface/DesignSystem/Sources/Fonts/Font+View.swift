//
//  Font+View.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public extension View {
    func fontStyle(
        _ font: Font.ZentryFontSystem,
        foregroundColor: Color.ZentryColorSystem = .grayScale(.gray12)) -> some View
    {
        self.modifier(FontModifier(font, foregroundColor: foregroundColor))
    }
}
