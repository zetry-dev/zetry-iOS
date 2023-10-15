//
//  SegmentedButton.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CoreKitInterface
import SwiftUI

public struct SegmentedButton<T: Segments>: View {
    @Binding private var selection: T
    private let segments: [T]
    private let index: Int
    private let segmentStyle: SegmentStyle
    private let animation: Namespace.ID

    init(
        selection: Binding<T>,
        segments: [T],
        index: Int,
        segmentStyle: SegmentStyle,
        animation: Namespace.ID
    ) {
        self._selection = selection
        self.segments = segments
        self.index = index
        self.segmentStyle = segmentStyle
        self.animation = animation
    }

    public var body: some View {
        let isSelected: Bool = selection.hashValue == segments[index].hashValue

        switch segmentStyle {
        case .line(let lineSegmentedStyle):
            segmentedLineButton(index: index, isSelected: isSelected, style: lineSegmentedStyle)
        case .button(let buttonSegmentedStyle):
            segmentedButton(index: index, isSelected: isSelected, style: buttonSegmentedStyle)
        }
    }

    @ViewBuilder
    private func segmentedLineButton(index: Int, isSelected: Bool, style: SegmentStyleProtocol) -> some View {
        VStack(spacing: 0) {
            Button {
                withAnimation(.easeInOut) {
                    self.selection = segments[index]
                }
            } label: {
                Text(segments[index].title)
                    .fontStyle(
                        isSelected ? style.selectedFontSize : style.unselectedFontSize,
                        foregroundColor: isSelected ? style.selectedColor : style.unselectedColor
                    )
            }
            .id(segments[index].hashValue)
            .padding(.vertical, 12)

            if isSelected {
                Color.zetry(style.lineColor)
                    .matchedGeometryEffect(id: "line", in: animation)
                    .frame(height: 2)
            } else {
                Color.clear
                    .frame(height: 2)
            }
        }
    }

    @ViewBuilder
    private func segmentedButton(index: Int, isSelected: Bool, style: SegmentStyleProtocol) -> some View {
        let isSelected: Bool = selection.hashValue == segments[index].hashValue

        Button {
            withAnimation(.easeInOut) {
                self.selection = segments[index]
            }
        } label: {
            Text(segments[index].title)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .fontStyle(
                    style.selectedFontSize,
                    foregroundColor: isSelected ? style.unselectedColor : style.selectedColor
                )
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.zetry(style.lineColor), lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.zetry(isSelected ? style.selectedColor : style.unselectedColor))
                        )
                )
        }
        .buttonStyle(.bounce)
        .id(segments[index].hashValue)
        .padding(.horizontal, 10)
    }
}
