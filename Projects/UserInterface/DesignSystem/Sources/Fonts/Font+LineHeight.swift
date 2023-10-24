//
//  Font+LineHeight.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/24.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI
public extension View {
    func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
        ModifiedContent(content: self, modifier: FontWithLineHeight(font: font, lineHeight: lineHeight))
    }
}

public struct FontWithLineHeight: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat

    public init(font: UIFont, lineHeight: CGFloat) {
        self.font = font
        self.lineHeight = lineHeight
    }

    public func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}
