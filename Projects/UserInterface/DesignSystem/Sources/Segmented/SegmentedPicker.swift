//
//  SegmentedPicker.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/31.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CoreKitInterface
import SwiftUI

public struct SegmentedPicker<T: Segments>: View {
    @Namespace private var animation
    @Binding private var selection: T

    private let segments: [T]
    private let fontSize: Font.ZetryFontSystem
    private let selectedColor: Color.ZetryColorSystem
    private let unselectedColor: Color.ZetryColorSystem
    private let lineColor: Color.ZetryColorSystem
    private let hasDivider: Bool
    private let horizontalPadding: CGFloat

    public init(
        _ selection: Binding<T>,
        segments: [T],
        fontSize: Font.ZetryFontSystem = .body1,
        selectedColor: Color.ZetryColorSystem = .grayScale(.gray12),
        unselectedColor: Color.ZetryColorSystem = .grayScale(.gray6),
        lineColor: Color.ZetryColorSystem = .primary(.primary),
        hasDivider: Bool = true,
        paddingHorizontal: CGFloat = 0.0
    ) {
        self._selection = selection
        self.segments = segments
        self.fontSize = fontSize
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        self.lineColor = lineColor
        self.hasDivider = hasDivider
        self.horizontalPadding = paddingHorizontal
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(segments.indices, id: \.self) { index in
                    segement(index: index)
                }
            }
            .padding(.horizontal, horizontalPadding)

            if hasDivider {
                Color.zetry(.grayScale(.gray2))
                    .frame(height: 1)
            }
        }
    }

    @ViewBuilder
    private func segement(index: Int) -> some View {
        let selected: Bool = selection.hashValue == segments[index].hashValue

        VStack(spacing: 0) {
            Button {
                withAnimation(.easeInOut) {
                    self.selection = segments[index]
                }
            } label: {
                Text(segments[index].title)
                    .fontStyle(
                        selected ? .subtitle3 : .body1,
                        foregroundColor: selected ? selectedColor : unselectedColor
                    )
            }
            .id(segments[index].hashValue)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            if selected {
                Color.zetry(lineColor)
                    .matchedGeometryEffect(id: "line", in: animation)
                    .frame(height: 2)
            } else {
                Color.clear
                    .frame(height: 2)
            }
        }
    }
}
