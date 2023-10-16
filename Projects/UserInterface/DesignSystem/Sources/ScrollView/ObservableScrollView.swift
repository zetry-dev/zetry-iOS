//
//  File.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/16.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct ObservableScrollView<Content>: View where Content: View {
    @Namespace var scrollSpace
    @Binding var scrollOffset: CGFloat
    let content: (ScrollViewProxy) -> Content

    public init(scrollOffset: Binding<CGFloat>,
                @ViewBuilder content: @escaping (ScrollViewProxy) -> Content) {
        _scrollOffset = scrollOffset
        self.content = content
    }

    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                content(proxy)
                    .background(
                        GeometryReader { geo in
                            let offset = -geo.frame(in: .named(scrollSpace)).origin.y
                            Color.clear.preference(
                                key: ScrollOffsetKey.self,
                                value: offset
                            )
                        }
                    )
            }
        }
        .coordinateSpace(name: scrollSpace)
        .onPreferenceChange(ScrollOffsetKey.self) { value in
            DispatchQueue.main.async {
                withAnimation {
                    scrollOffset = value
                }
            }
        }
    }
}
