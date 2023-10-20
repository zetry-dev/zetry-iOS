//
//  CollapsingScrollView.swift
//  DesignSystem
//
//  Created by AllieKim on 2023/10/16.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI

public struct CollapsingScrollView<
    Header: View,
    Title: View,
    Banner: View,
    Background: View,
    Content: View
>: View {
    @ObservedObject private var articleContent: ViewFrame = .init()
    @State private var titleRect: CGRect = .zero
    @State private var headerImageRect: CGRect = .zero

    private let headerView: () -> Header
    private let titleView: () -> Title
    private let bannerView: () -> Banner
    private let backgroundView: () -> Background
    private let contentView: () -> Content
    private let imageHeight: CGFloat
    private let collapsedImageHeight: CGFloat

    public init(
        imageHeight: CGFloat,
        headerHeight: CGFloat = 120,
        headerView: @escaping () -> Header,
        titleView: @escaping () -> Title,
        bannerView: @escaping () -> Banner,
        backgroundView: @escaping () -> Background,
        contentView: @escaping () -> Content
    ) {
        self.headerView = headerView
        self.titleView = titleView
        self.bannerView = bannerView
        self.contentView = contentView
        self.backgroundView = backgroundView
        self.imageHeight = imageHeight
        self.collapsedImageHeight = headerHeight
    }

    public var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 10) {
                    headerView()
                        .background(GeometryGetter(rect: $titleRect))
                    contentView()
                }
                .padding(.top, 16.0)
            }
            .offset(y: imageHeight)
            .background(GeometryGetter(rect: $articleContent.frame))

            GeometryReader { geometry in
                let width = geometry.size.width
                let headerOffset = self.getOffsetForHeaderImage(geometry)

                ZStack(alignment: .bottom) {
                    ZStack(alignment: .top) {
                        // MARK: - Blur Image Background

                        backgroundView()
                            .frame(
                                width: width,
                                height: imageHeight
                            )
                            .blur(radius: 10)
                            .background(GeometryGetter(rect: self.$headerImageRect))

                        // MARK: - Contents

                        ZStack(alignment: .topLeading) {
                            bannerView()
                                .offset(y: 40)
                                .frame(
                                    width: width - 32,
                                    height: imageHeight - (imageHeight * 0.3)
                                )
                                .opacity(headerOffset > 0 ? 0 : 1)

                            titleView()
                        }
                        .padding(.top, 60)
                    }

                    headerView()
                        .offset(x: 0, y: self.getHeaderTitleOffset())
                }
                .clipped()
                .offset(x: 0, y: headerOffset)
            }
            .frame(height: imageHeight)
            .offset(x: 0, y: -(articleContent.startingRect?.maxY ?? UIScreen.main.bounds.height))
        }
        .edgesIgnoringSafeArea(.top)
    }

    private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }

    private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let sizeOffScreen = imageHeight - collapsedImageHeight
        if offset < -sizeOffScreen {
            let imageOffset = abs(min(-sizeOffScreen, offset))
            return imageOffset - sizeOffScreen
        }
        if offset > 0 {
            return -offset
        }
        return 0
    }

    private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).minY
        if 0 ... 100 ~= Int(offset) {
            return imageHeight + offset
        }
        return imageHeight
    }

    private func getHeaderTitleOffset() -> CGFloat {
        let currentYPos = titleRect.midY
        if currentYPos < headerImageRect.maxY {
            let minYValue: CGFloat = 0.0
            let maxYValue: CGFloat = collapsedImageHeight
            let percentage = max(-1, (currentYPos - maxYValue) / (maxYValue - minYValue))
            let finalOffset: CGFloat = -40.0
            return 20 - percentage * finalOffset
        }
        return .infinity
    }
}

class ViewFrame: ObservableObject {
    var startingRect: CGRect?

    var frame: CGRect {
        willSet {
            if startingRect == nil {
                startingRect = newValue
            }
        }
    }

    init() {
        self.frame = .zero
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(
                    key: RectanglePreferenceKey.self,
                    value: geometry.frame(in: .global)
                )
        }
        .onPreferenceChange(RectanglePreferenceKey.self) {
            self.rect = $0
        }
    }
}

struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
