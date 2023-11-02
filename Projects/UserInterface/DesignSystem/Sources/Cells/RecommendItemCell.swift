//
//  RecommendItemCell.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/24.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct RecommendItemCell: View {
    private let imageURL: String
    private let text: String
    private let action: () -> Void

    public init(_ text: String, imageURL: String, action: @escaping () -> Void) {
        self.text = text
        self.imageURL = imageURL
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 25) {
                Image
                    .load(
                        imageURL,
                        width: 62,
                        height: 62
                    )
                Text(text)
                    .fontStyle(.body2, foregroundColor: .grayScale(.gray9))
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 20)
            .background(.white.opacity(0.8))
            .cornerRadius(4)
            .shadow(
                color: Color(red: 0.87, green: 0.9, blue: 0.92).opacity(0.47),
                radius: 8,
                x: 0,
                y: 4
            )
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .inset(by: 0.5)
                    .stroke(.white, lineWidth: 1)
            )
        }
        .buttonStyle(.bounce)
    }
}
