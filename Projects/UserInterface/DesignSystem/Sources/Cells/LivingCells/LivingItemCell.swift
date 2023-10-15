//
//  LivingItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/04.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct LivingListItemCell: View {
    private let imageURL: String
    private let title: String
    private let subtitle: String

    public init(_ title: String, subtitle: String, imageURL: String) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 16) {
            CachedAsyncImage(
                url: URL(string: imageURL)
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Color.zetry(.grayScale(.gray2))
                }
            }
            .frame(width: 110, height: 110)
            .background(Color.zetry(.grayScale(.gray2)))
            .cornerRadius(4)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .fontStyle(.subtitle2)
                Text(subtitle)
                    .fontStyle(.label2)
            }
            .padding(.top, 4)
        }
    }
}
