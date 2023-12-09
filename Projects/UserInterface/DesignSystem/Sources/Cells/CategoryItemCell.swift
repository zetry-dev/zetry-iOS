//
//  CategoryItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/01.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CoreKitInterface
import SwiftUI

public struct CategoryItemCell: View {
    private let title: String
    private let imageUrl: String
    private let icon: DesignSystemImages?
    private let size: CGFloat
    private let action: () -> Void

    public init(
        _ title: String,
        imageUrl: String,
        icon: DesignSystemImages? = nil,
        size: CGFloat,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.imageUrl = imageUrl
        self.icon = icon
        self.size = size
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 8) {
                if !imageUrl.isEmpty {
                    Image
                        .load(imageUrl, width: size, height: size)
                        .cornerRadius(20)
                } else {
                    if let icon {
                        icon.swiftUIImage
                    } else {
                        Color
                            .zetry(.grayScale(.gray2))
                            .frame(width: size, height: size)
                            .cornerRadius(20)
                    }
                }

                MultilineText(title, lineLimit: 2, font: .body3)
            }
        }
        .buttonStyle(.bounce)
    }
}
