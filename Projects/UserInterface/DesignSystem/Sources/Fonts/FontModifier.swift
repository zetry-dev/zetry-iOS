//
//  FontModifier.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

struct FontModifier: ViewModifier {
    private var font: Font.ZetryFontSystem
    private var foregroundColor: Color.ZetryColorSystem

    init(_ font: Font.ZetryFontSystem, foregroundColor: Color.ZetryColorSystem) {
        self.font = font
        self.foregroundColor = foregroundColor
    }

    func body(content: Content) -> some View {
        content
            .font(.zetry(font))
            .foregroundColor(.zetry(foregroundColor))
    }
}
