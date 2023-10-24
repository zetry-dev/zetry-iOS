//
//  CategoryItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/01.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct CategoryItemCell: View {
    private let title: String
    private let imageUrl: String
    private let size: CGFloat
    private let action: () -> Void

    public init(_ title: String, imageUrl: String, size: CGFloat, action: @escaping () -> Void) {
        self.title = title
        self.imageUrl = imageUrl
        self.size = size
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 8) {
                Image
                    .load(imageUrl, width: size, height: size)
                    .background(Color.zetry(.grayScale(.gray2)))
                    .cornerRadius(20)

                Text(title)
                    .fontStyle(.body2)
            }
        }
        .buttonStyle(.bounce)
    }
}
