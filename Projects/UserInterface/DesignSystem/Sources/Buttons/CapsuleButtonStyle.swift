//
//  CapsuleButtonStyle.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct CapsuleButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .fontStyle(.label2)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.zetry(.grayScale(.gray2)), lineWidth: 1)
            }
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

public extension ButtonStyle where Self == CapsuleButtonStyle {
    static var capsule: CapsuleButtonStyle {
        self.init()
    }
}
