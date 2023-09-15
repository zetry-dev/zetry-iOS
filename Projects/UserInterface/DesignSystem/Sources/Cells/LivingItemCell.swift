//
//  LivingItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/04.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct LivingItemCell: View {
    private let imageURL: String
    private let title: String

    public init(_ title: String, imageURL: String) {
        self.title = title
        self.imageURL = imageURL
    }

    public var body: some View {
        VStack(alignment: .leading) {
            CachedAsyncImage(
                url: URL(string: imageURL)
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Color.zetry(.grayScale(.gray3))
                        .frame(height: 150)
                }
            }
            .background(Color.zetry(.grayScale(.gray2)))

            Text(title)
                .fontStyle(.body2)
        }
    }
}
