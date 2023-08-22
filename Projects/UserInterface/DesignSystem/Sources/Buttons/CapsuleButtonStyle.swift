//
//  CapsuleButtonStyle.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public struct CapsuleButtonStyle: PrimitiveButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .fontStyle(.label2)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.zentry(.grayScale(.gray2)), lineWidth: 1)
            }
    }
}

public extension PrimitiveButtonStyle where Self == CapsuleButtonStyle {
    static var capsule: CapsuleButtonStyle {
        self.init()
    }
}
