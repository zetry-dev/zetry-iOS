//
//  Divider.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/13.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct Divider: View {
    let color: Color.ZetryColorSystem.GrayScale
    let height: CGFloat

    public init(color: Color.ZetryColorSystem.GrayScale = .gray0, height: CGFloat = 1) {
        self.color = color
        self.height = height
    }

    public var body: some View {
        Color
            .zetry(.grayScale(color))
            .frame(height: height)
    }
}
