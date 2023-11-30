//
//  ZetryPrimaryButtonStyle.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/25.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct ZetryPrimaryButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .fontStyle(.body2, foregroundColor: .primary(.white))
            .padding(10)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.zetry(.primary(.primary)))
            }
    }
}

public extension ButtonStyle where Self == ZetryPrimaryButtonStyle {
    static var primary: ZetryPrimaryButtonStyle {
        self.init()
    }
}
