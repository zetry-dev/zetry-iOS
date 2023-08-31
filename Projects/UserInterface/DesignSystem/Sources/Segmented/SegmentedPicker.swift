//
//  SegmentedPicker.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/08/31.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public protocol Segments: Hashable {
    var title: String { get }
}

public struct SegmentedPicker<T: Segments>: View {
    @Namespace private var animation
    @Binding private var selection: T
    private let segments: [T]
    private let fontSize: Font.ZetryFontSystem
    private let selectedColor: Color.ZetryColorSystem
    private let unselectedColor: Color.ZetryColorSystem
    private let lineColor: Color.ZetryColorSystem

    @State private var scrollViewContentSize: CGSize = .init()

    public init(
        _ selection: Binding<T>,
        segments: [T],
        fontSize: Font.ZetryFontSystem = .body1,
        selectedColor: Color.ZetryColorSystem = .primary(.primary),
        unselectedColor: Color.ZetryColorSystem = .grayScale(.gray6),
        lineColor: Color.ZetryColorSystem = .primary(.primary)
    ) {
        self._selection = selection
        self.segments = segments
        self.fontSize = fontSize
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        self.lineColor = lineColor
    }

    public var body: some View {
        HStack {
            ForEach(segments.indices, id: \.self) { index in
                segement(index: index)
            }
        }
    }

    @ViewBuilder
    private func segement(index: Int) -> some View {
        let selected: Bool = selection.hashValue == segments[index].hashValue

        VStack {
            Button {
                withAnimation(.easeInOut) {
                    self.selection = segments[index]
                }
            } label: {
                Text(segments[index].title)
                    .fontStyle(.body1)
                    .foregroundColor(.zetry(selected ? selectedColor : unselectedColor))
            }
            .id(segments[index].hashValue)

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
