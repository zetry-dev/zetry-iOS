//
//  BulletText.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/24.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CoreKitInterface
import SwiftUI

public struct BulletText: View {
    private let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 10) {
            Circle()
                .foregroundColor(.zetry(.grayScale(.gray10)))
                .frame(width: 4, height: 4)
                .padding(.bottom, 4)
            MultilineText(text, font: .label1, foregroudColor: .grayScale(.gray10))
                .fontWithLineHeight(font: Font.zetry(.label1), lineHeight: 24)
        }
    }
}
