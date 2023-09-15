//
//  BouncyButtonStyle.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct BouncyButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeOut, value: configuration.isPressed == true)
    }
}

public extension ButtonStyle where Self == BouncyButtonStyle {
    static var bounce: BouncyButtonStyle {
        self.init()
    }
}
