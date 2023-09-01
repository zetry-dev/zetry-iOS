//
//  SearchableTextField.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct SearchableTextField: View {
    @Binding private var text: String
    private var prompt: String
    private var focusedField: FocusState<Bool>.Binding
    private var maxCount: Int = 20

    public init(_ text: Binding<String>, prompt: String = "", focused: FocusState<Bool>.Binding) {
        self._text = text
        self.prompt = prompt
        self.focusedField = focused
    }

    public var body: some View {
        HStack(spacing: 4) {
            ZetryIcon(DesignSystemAsset.Icons.magnifyingglass,
                      foregroundColor: .grayScale(.gray6))
            TextField(
                "",
                text: $text,
                prompt: Text(prompt)
                    .font(.zetry(.body2))
                    .foregroundColor(.zetry(.grayScale(.gray6)))
            )
            .onChange(of: text) {
                if $0.count > maxCount {
                    text = String($0.prefix(maxCount))
                }
            }
            .fontStyle(.body2)
            .focused(focusedField)
            .submitLabel(.search)

            if !text.isEmpty {
                ZetryIcon(DesignSystemAsset.Icons.xmarkCircleFill)
                    .onTapGesture {
                        text = ""
                    }
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 7)
        .background(Color.zetry(.grayScale(.gray1)))
        .cornerRadius(8)
    }
}
