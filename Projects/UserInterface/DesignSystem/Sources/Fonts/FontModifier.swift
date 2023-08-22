//
//  FontModifier.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

struct FontModifier: ViewModifier {
    private var font: Font.ZentryFontSystem
    private var foregroundColor: Color.ZentryColorSystem

    init(_ font: Font.ZentryFontSystem, foregroundColor: Color.ZentryColorSystem) {
        self.font = font
        self.foregroundColor = foregroundColor
    }

    func body(content: Content) -> some View {
        content
            .font(.zentry(font))
            .foregroundColor(.zentry(foregroundColor))
    }
}
