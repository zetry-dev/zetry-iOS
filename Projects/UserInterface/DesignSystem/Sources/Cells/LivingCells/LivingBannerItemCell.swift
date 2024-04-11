//
//  LivingBannerItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CoreKitInterface
import SwiftUI

public struct LivingBannerItemCell: View {
    private let imageURL: String
    private let title: String
    private let subtitle: String

    public init(_ title: String, subtitle: String, imageURL: String) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image
                .load(imageURL, height: 220, centerCropped: false)
                .background(Color.zetry(.grayScale(.gray2)))
                .cornerRadius(4)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .lineLimit(1)
                    .fontStyle(.subtitle2)

                MultilineText(subtitle, lineLimit: 2, font: .body3)
                    .fontWithLineHeight(font: Font.zetry(.body3), lineHeight: 20)
            }
        }
    }
}
