//
//  Divider.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/13.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct Divider: View {
    let color: Color.ZetryColorSystem
    let height: CGFloat
    let opacity: Double

    public init(color: Color.ZetryColorSystem, height: CGFloat = 1, opacity: Double = 1) {
        self.color = color
        self.height = height
        self.opacity = opacity
    }

    public var body: some View {
        Color
            .zetry(color)
            .opacity(opacity)
            .frame(height: height)
    }
}
