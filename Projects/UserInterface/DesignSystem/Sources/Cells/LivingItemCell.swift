//
//  LivingItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/04.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct LivingItemCell: View {
    private let imageUrl: String
    private let title: String
    private let height: CGFloat

    public init(_ title: String, imageUrl: String, height: CGFloat) {
        self.title = title
        self.imageUrl = imageUrl
        self.height = height
    }

    public var body: some View {
        VStack(alignment: .leading) {
            CachedAsyncImage(
                url: URL(string: imageUrl)
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                default:
                    Color.zetry(.grayScale(.gray3))
                }
            }
            .frame(height: height)
            .background(Color.zetry(.grayScale(.gray2)))
            .cornerRadius(20)

            Text(title)
                .fontStyle(.body2)
        }
    }
}
