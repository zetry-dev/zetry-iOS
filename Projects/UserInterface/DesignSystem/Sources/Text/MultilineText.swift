//
//  MultilineText.swift
//  DesignSystem
//
//  Created by Allie Kim on 2023/11/03.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CoreKitInterface
import SwiftUI

public struct MultilineText: View {
    private let text: String
    private let lineLimit: Int?
    private let font: Font.ZetryFontSystem
    private let foregroudColor: Color.ZetryColorSystem

    public init(
        _ text: String,
        lineLimit: Int? = nil,
        font: Font.ZetryFontSystem,
        foregroudColor: Color.ZetryColorSystem = .grayScale(.gray12))
    {
        self.text = text
        self.lineLimit = lineLimit
        self.font = font
        self.foregroudColor = foregroudColor
    }

    public var body: some View {
        Text(text.nonBreakingSpaced())
            .lineLimit(lineLimit)
            .fontStyle(font, foregroundColor: foregroudColor)
            .multilineTextAlignment(.leading)
    }
}
