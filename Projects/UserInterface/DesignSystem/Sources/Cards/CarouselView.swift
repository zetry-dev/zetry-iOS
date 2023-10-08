//
//  CarouselView.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/09/12.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct Card: Identifiable, Equatable, Hashable {
    public var id: String
    public var title: String
    public var color: Color
    public var imageURL: String

    public init(title: String, color: Color, imageURL: String) {
        self.id = UUID().uuidString
        self.title = title
        self.color = color
        self.imageURL = imageURL
    }
}

public struct CarouselView<Content: View>: View {
    var content: (Card, CGSize, Int) -> Content
    var spacing: CGFloat
    var cardPadding: CGFloat
    @Binding var items: [Card]
    @Binding var index: Int

    @GestureState var translation: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    @State var currentIndex: Int = 0

    public init(
        index: Binding<Int>,
        items: Binding<[Card]>,
        spacing: CGFloat = 30,
        cardPadding: CGFloat = 80,
        @ViewBuilder content: @escaping (Card, CGSize, Int) -> Content
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
            LazyHStack(spacing: spacing) {
                ForEach(items.indices, id: \.self) { index in
                    let height = getHeight(size, index: indexOf(item: items[index]))

                    content(items[index], CGSize(width: size.width - cardPadding, height: height), index)
                        .frame(width: size.width - cardPadding, height: height)
                        .contentShape(Rectangle())
                }
            }
            .animation(.easeInOut, value: UUID())
            .padding(.horizontal, spacing)
            .contentShape(Rectangle())
            .offset(x: limitScroll())
            .gesture(
                DragGesture(minimumDistance: 5)
                    .onChanged { onChanged(value: $0, cardWidth: cardWidth) }
                    .onEnded {
                        onEnded(value: $0, cardWidth: cardWidth)
                        fetchMore()
                    }
            )
        }
//        .onAppear {
//            let extraSpace = (cardPadding / 2) - spacing
//            offset = extraSpace
//            lastStoredOffset = extraSpace
//        }
    }

    private func indexOf(item: Card) -> Int {
        let array = items
        if let index = array.firstIndex(of: item) {
            return index
        }
        return 0
    }

    private func getHeight(_ size: CGSize, index: Int) -> CGFloat {
        var height = size.width
        if self.index != index {
            height = size.width - 40
        }
        return height
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
        let extraSpace = (cardPadding / 2) - spacing
        offset = (cardWidth * index) + extraSpace
        withAnimation {
            lastStoredOffset = offset
        }
    }

    private func fetchMore() {
        if self.index == items.count - 2 {
            var itemsArray = Array(items.prefix(3))
            itemsArray = itemsArray.map { item in
                var mutableItem = item
                mutableItem.id = UUID().uuidString
                return mutableItem
            }
            self.items.append(contentsOf: itemsArray)
        }
    }
}

// public struct CarouselView<Content: View, Item>: View
//    where Item: Collection & RandomAccessCollection,
////    ID: Hashable,
//    Item.Element: Equatable & Hashable & Identifiable {
//    var content: (Item.Element, CGSize) -> Content
////    var id: KeyPath<Item.Element, ID>
//
//    var spacing: CGFloat
//    var cardPadding: CGFloat
//    var appendableItem: Item
//    @Binding var items: Item
//    @Binding var index: Int
//
//    @GestureState var translation: CGFloat = 0
//    @State var offset: CGFloat = 0
//    @State var lastStoredOffset: CGFloat = 0
//    @State var currentIndex: Int = 0
//
//    public init(
//        index: Binding<Int>,
//        items: Binding<Item>,
//        spacing: CGFloat = 30,
//        cardPadding: CGFloat = 80,
////        id: KeyPath<Item.Element, ID>,
//        @ViewBuilder content: @escaping (Item.Element, CGSize) -> Content
//    ) {
//        self.content = content
////        self.id = id
//        self._index = index
//        self.spacing = spacing
//        self.cardPadding = cardPadding
//        self.appendableItem = items.wrappedValue
//        self._items = items
//    }
//
//    public var body: some View {
//        GeometryReader { proxy in
//            let size = proxy.size
//            let cardWidth = size.width - (cardPadding - spacing)
//            LazyHStack(spacing: spacing) {
//                ForEach(items) {
//                    let index = indexOf(item: $0)
//                    let height = getHeight(size, index: index)
//                    content($0, CGSize(width: size.width - cardPadding, height: height))
//                        .frame(width: size.width - cardPadding, height: height)
//                        .contentShape(Rectangle())
//                }
//            }
//            .animation(.easeInOut, value: UUID())
//            .padding(.horizontal, spacing)
//            .contentShape(Rectangle())
//            .offset(x: limitScroll())
//            .gesture(
//                DragGesture(minimumDistance: 5)
//                    .updating($translation, body: { value, out, _ in
//                        out = value.translation.width
//                    })
//                    .onChanged { onChanged(value: $0, cardWidth: cardWidth) }
//                    .onEnded {
//                        onEnded(value: $0, cardWidth: cardWidth)
//                        fetchMore()
//                    }
//            )
//        }
//        .onAppear {
//            let extraSpace = (cardPadding / 2) - spacing
//            offset = extraSpace
//            lastStoredOffset = extraSpace
//        }
//        .animation(.easeInOut, value: translation == 0)
//    }
//
//    private func indexOf(item: Item.Element) -> Int {
//        let array = Array(items)
//        if let index = array.firstIndex(of: item) {
//            return index
//        }
//        return 0
//    }
//
//    private func getHeight(_ size: CGSize, index: Int) -> CGFloat {
//        var height = size.height
//        if self.index != index {
//            height = size.height - 40
//        }
//        return height
//    }
//
//    private func limitScroll() -> CGFloat {
//        let extraSpace = (cardPadding / 2) - spacing
//        if index == 0, offset > extraSpace {
//            return extraSpace + (offset / 4)
//        } else if index == items.count - 1, translation < 0 {
//            return offset - (translation / 2)
//        } else {
//            return offset
//        }
//    }
//
//    private func onChanged(value: DragGesture.Value, cardWidth: CGFloat) {
//        let translationX = value.translation.width
//        offset = translationX + lastStoredOffset
//    }
//
//    private func onEnded(value: DragGesture.Value, cardWidth: CGFloat) {
//        var index = (offset / cardWidth).rounded()
//        index = max(-CGFloat(items.count - 1), index)
//        index = min(index, 0)
//
//        currentIndex = Int(index)
//        self.index = -currentIndex
//        withAnimation(.easeOut(duration: 0.25)) {
//            let extraSpace = (cardPadding / 2) - spacing
//            offset = (cardWidth * index) + extraSpace
//        }
//        lastStoredOffset = offset
//    }
//
//    private func fetchMore() {
//        if self.index == items.count - 1 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                var itemsArray = Array(appendableItem)
//                var array = Array(self.items)
//                array.append(contentsOf: appendableItem)
//
//                withAnimation {
//                    self.items = array as? Item ?? items
//                }
//            }
//        }
//    }
// }
