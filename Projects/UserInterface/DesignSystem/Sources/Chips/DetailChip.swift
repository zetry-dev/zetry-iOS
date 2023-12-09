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
                ZetryIcon(icon, foregroundColor: .primary(.primary), size: .custom(width: 14, height: 14))
            }

            let fontColor: Color.ZetryColorSystem = icon != nil ? .primary(.primary) : .grayScale(.gray12)

            Text(text)
                .fontStyle(.body3, foregroundColor: fontColor)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .overlay {
            let strokeColor: Color.ZetryColorSystem = icon != nil ? .primary(.primary) : .grayScale(.gray5)
            Capsule()
                .stroke(Color.zetry(strokeColor), lineWidth: 1)
        }
    }
}
