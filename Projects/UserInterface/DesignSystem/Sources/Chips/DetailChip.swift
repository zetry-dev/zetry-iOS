//
//  DetailChip.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/24.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct DetailChip: View {
    public let icon: DesignSystemImages?
    public let text: String

    public init(text: String, icon: DesignSystemImages? = nil) {
        self.text = text
        self.icon = icon
    }

    public var body: some View {
        HStack(spacing: 4) {
            if let icon {
                ZetryIcon(icon, foregroundColor: .primary(.white), size: .custom(.init(width: 14, height: 14)))
            }
            Text(text)
                .fontStyle(.body2, foregroundColor: .primary(.white))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.zetry(.grayScale(.gray5)).opacity(0.7))
        .clipShape(Capsule())
    }
}
