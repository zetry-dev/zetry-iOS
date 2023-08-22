//
//  SearchableTextField.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/22.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import SwiftUI

public struct SearchableTextField: View {
    @Binding private var text: String
    private var prompt: String
    private var focusedField: FocusState<Bool>.Binding

    public init(_ text: Binding<String>, prompt: String = "", focused: FocusState<Bool>.Binding) {
        self._text = text
        self.prompt = prompt
        self.focusedField = focused
    }

    public var body: some View {
        HStack(spacing: 4) {
            ZentryIcon(DesignSystemAsset.Icons.magnifyingglassSizeSmaller,
                       foregroundColor: .grayScale(.gray6))
            TextField(
                "",
                text: $text,
                prompt: Text(prompt)
                    .font(.zentry(.body2))
                    .foregroundColor(.zentry(.grayScale(.gray6)))
            )
            .fontStyle(.body2)
            .focused(focusedField)
            .submitLabel(.search)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 7)
        .background(Color.zentry(.grayScale(.gray1)))
        .cornerRadius(8)
    }
}
