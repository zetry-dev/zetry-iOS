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
    private let segmentStyle: SegmentStyle
    private let horizontalPadding: CGFloat

    public init(
        _ selection: Binding<T>,
        segments: [T],
        segmentStyle: SegmentStyle,
        paddingHorizontal: CGFloat = 0.0
    ) {
        self._selection = selection
        self.segments = segments
        self.horizontalPadding = paddingHorizontal
        self.segmentStyle = segmentStyle
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(segments.indices, id: \.self) { index in
                    segement(index: index)
                }
            }
            .padding(.horizontal, horizontalPadding)
            .frame(maxWidth: .infinity)

            if case .line = segmentStyle {
                Color.zetry(.grayScale(.gray2))
                    .frame(height: 1)
            }
        }
    }

    @ViewBuilder
    private func segement(index: Int) -> some View {
        SegmentedButton(
            selection: $selection,
            segments: segments,
            index: index,
            segmentStyle: segmentStyle,
            animation: animation
        )
    }
}
