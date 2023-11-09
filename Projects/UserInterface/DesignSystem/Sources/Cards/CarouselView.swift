//
//  CarouselView.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/12.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI
import CoreKitInterface

public struct CarouselView<Content: View, Item: Banner>: View {
    var content: (Item, CGSize, Int) -> Content
    var spacing: CGFloat
    var cardPadding: CGFloat
    @Binding var items: [Item]
    @Binding var index: Int

    @GestureState var translation: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    @State var currentIndex: Int = 0

    public init(
        index: Binding<Int>,
        items: Binding<[Item]>,
        spacing: CGFloat = 30,
        cardPadding: CGFloat = 80,
        @ViewBuilder content: @escaping (Item, CGSize, Int) -> Content
    ) {
        self.content = content
        self._index = index
        self.spacing = spacing
        self.cardPadding = cardPadding
        self._items = items
    }

    public var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let cardWidth = size.width - (cardPadding - spacing)
            HStack(spacing: spacing) {
                ForEach(items.indices, id: \.self) { index in
                    let height = getHeight(size, index: indexOf(item: items[index]))

                    content(items[index], CGSize(width: size.width - cardPadding, height: height - cardPadding), index)
                        .frame(height: height - cardPadding)
                        .contentShape(Rectangle())
                }
            }
            .animation(.easeInOut, value: UUID())
            .padding(.horizontal, spacing)
            .contentShape(Rectangle())
            .offset(x: limitScroll())
            .gesture(
                DragGesture(minimumDistance: 5)
                    .updating(
                        $translation,
                        body: { value, out, _ in
                            out = value.translation.width
                        }
                    )
                    .onChanged { onChanged(value: $0, cardWidth: cardWidth) }
                    .onEnded {
                        onEnded(value: $0, cardWidth: cardWidth)
//                        fetchMore()
                    }
            )
        }
        .onAppear {
            let extraSpace = (cardPadding / 2) - spacing
            offset = extraSpace
            lastStoredOffset = extraSpace
        }
    }

    private func indexOf(item: Item) -> Int {
        let array = items
        if let index = array.firstIndex(of: item) {
            return index
        }
        return 0
    }

    private func getHeight(_ size: CGSize, index: Int) -> CGFloat {
        if self.index != index {
            return size.width - 40 + abs(translation) * 0.1
        }
        return size.width - abs(translation) * 0.1
    }

    private func limitScroll() -> CGFloat {
        let extraSpace = (cardPadding / 2) - spacing
        if index == 0, offset > extraSpace {
            return extraSpace + (offset / 4)
        } else if index == items.count - 1, translation < 0 {
            return offset - (translation / 2)
        } else {
            return offset
        }
    }

    private func onChanged(value: DragGesture.Value, cardWidth: CGFloat) {
        let translationX = value.translation.width
        offset = translationX + lastStoredOffset
    }

    private func onEnded(value: DragGesture.Value, cardWidth: CGFloat) {
        var index = (offset / cardWidth).rounded()
        index = max(-CGFloat(items.count - 1), index)
        index = min(index, 0)

        currentIndex = Int(index)
        self.index = -currentIndex
        withAnimation(.easeInOut) {
            let extraSpace = (cardPadding / 2) - spacing
            offset = (cardWidth * index) + extraSpace
        }
        lastStoredOffset = offset
    }

    private func fetchMore() {
        if self.index == items.count - 2 {
            var itemsArray = Array(items.prefix(3))
            itemsArray = itemsArray.map { item in
                var mutableItem = item
//                mutableItem.id = UUID().uuidString
                return mutableItem
            }
            self.items.append(contentsOf: itemsArray)
        }
    }
}

