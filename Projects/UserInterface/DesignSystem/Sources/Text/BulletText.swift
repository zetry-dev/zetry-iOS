//
//  BulletText.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/24.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct BulletText: View {
    private let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text("•")
                .fontStyle(.body1, foregroundColor: .primary(.primary))
            Text(text)
                .fontWithLineHeight(font: Font.zetry(.label1), lineHeight: 24)
                .fontStyle(.label1)
        }
        .multilineTextAlignment(.leading)
    }
}
