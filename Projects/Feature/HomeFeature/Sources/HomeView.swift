//
//  HomeView.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct HomeView: View {
    public let store: StoreOf<HomeStore>
    private let categoryColumns: [GridItem] = Array(repeating: .init(.flexible(), alignment: .top), count: 5)
    private let blurWiodth: CGFloat = UIScreen.main.bounds.width
    private let blurHeight: CGFloat = UIScreen.main.bounds.height * 0.55

    public init(store: StoreOf<HomeStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            ZStack(alignment: .bottom) {
                ObservableScrollView(
                    scrollOffset: viewStore.binding(
                        get: \.scrollViewOffsetY,
                        send: HomeStore.Action.scrollOffsetYChanged
                    )) { _ in
                        LazyVStack(
                            alignment: .leading,
                            spacing: 0,
                            pinnedViews: [.sectionHeaders],
                            content: {
                                Section {
                                    VStack(alignment: .leading, spacing: 0) {
                                        carouselView(viewStore: viewStore)
                                            .padding(.top, 15)
                                            .blurImageBackground(
                                                imageURL: viewStore.cards[viewStore.carouselCurrentIndex].imageURL,
                                                size: .init(width: blurWiodth, height: blurHeight)
                                            )
                                        VStack(alignment: .leading, spacing: 0) {
                                            categorySectionView(viewStore: viewStore)
                                            livingSectionView(viewStore: viewStore)
                                        }
                                    }
                                } header: {
                                    VStack(alignment: .leading, spacing: 0) {
                                        // TODO: -로고 반영
                                        Text("zetry")
                                            .fontStyle(
                                                .subtitle1,
                                                foregroundColor:
                                                viewStore.scrollViewOffsetY * 0.002 > 0.5 ?
                                                    .grayScale(.gray12) : .primary(.white)
                                            )
                                            .padding(.leading, 16)
                                            .padding(.bottom, 16)
                                            .padding(.top, 50)

                                        searchNavigationView(viewStore.scrollViewOffsetY * 0.002)
                                            .onTapGesture {
                                                viewStore.send(.routeToSearch)
                                            }
                                    }
                                    .animation(.none, value: UUID())
                                    .background(
                                        .thinMaterial.opacity(viewStore.scrollViewOffsetY * 0.002)
                                    )
                                }
                            }
                        )
                    }
            }
            .edgesIgnoringSafeArea(.top)
            .onLoad {
                viewStore.send(.onLoad)
            }
        }
    }

    @ViewBuilder
    private func carouselView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        CarouselView(
            index: viewStore.binding(get: \.carouselCurrentIndex, send: HomeStore.Action.indexChanged),
            items: viewStore.binding(get: \.cards, send: HomeStore.Action.cardChanged),
            spacing: 16,
            cardPadding: 64
        ) { card, cardSize, index in
            CachedAsyncImage(
                url: URL(string: card.imageURL)
            ) { phase in
                switch phase {
                case .success(let image):
                    carouselItem(viewStore: viewStore, image: image, args: (card, cardSize, index))
                default:
                    Color
                        .zetry(.grayScale(.gray3))
                        .frame(width: cardSize.width, height: cardSize.width)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }

    @ViewBuilder
    private func carouselItem(
        viewStore: ViewStoreOf<HomeStore>,
        image: Image,
        args: (Card, CGSize, Int)
    ) -> some View {
        let (card, size, index) = args

        image
            .resizable()
            .scaledToFill()
            .frame(width: size.width)
            .overlay(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("#\(index + 1)")
                        // TODO: - card.category
                        Text("생활정보")
                    }
                    .fontStyle(.subtitle3, foregroundColor: .primary(.white))
                    .padding(.leading, 15)

                    Spacer()
                    // TODO: - card.title
                    Text("친환경 제품을\n소개합니다")
                        .fontStyle(.subtitle2, foregroundColor: .primary(.white))
                        .padding(.leading, 30)
                }
                .padding(.vertical, 30)
            }
            .onTapGesture {
                // TODO: - route to living detail
                print("route to living detail")
//                card.link
            }
    }

    @ViewBuilder
    private func categorySectionView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        LazyVGrid(columns: categoryColumns) {
            ForEach(0 ..< 5, id: \.self) { index in
                let itemTitle = viewStore.categories[safe: index]?.title ?? ""
                CategoryItemCell(
                    itemTitle,
                    size: 54,
                    imageUrl: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
                )
                .animatedList(viewStore.isAnimated, index: index)
                .onTapGesture {
                    if index == 4 {
                        _ = withAnimation(.linear) {
                            viewStore.send(.toggleCategory)
                        }
                    }
                }
            }

            if viewStore.isCateogryExpandend {
                ForEach(5 ..< viewStore.categories.count, id: \.self) { index in
                    let itemTitle = viewStore.categories[safe: index]?.title ?? ""
                    CategoryItemCell(
                        itemTitle,
                        size: 54,
                        imageUrl: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
                    )
                }
            }
        }
//        .padding(.top, 26)
    }

    @ViewBuilder
    private func livingSectionView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("생활정보")
                .fontStyle(.subtitle1)

            ForEach(0 ... 5, id: \.self) { index in
                LivingItemCell(
                    "쓰레기 잘 버리는 법",
                    subtitle: "잘 버리세요.",
                    imageURL: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
                )
                .animatedList(viewStore.isAnimated, index: index)
                .onTapGesture {
                    viewStore.send(.routeToLiving)
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 15)
    }

    @ViewBuilder
    private func searchNavigationView(_ opacity: CGFloat) -> some View {
        let foregroundColor: Color.ZetryColorSystem = opacity > 0.5 ? .grayScale(.gray12) : .primary(.white)

        HStack {
            HStack(spacing: 10) {
                ZetryIcon(
                    DesignSystemAsset.Icons.magnifyingglass,
                    foregroundColor: foregroundColor,
                    size: .larger
                )

                Text("분리수거 방법이 궁금한 쓰레기를 검색해보세요.")
                    .fontStyle(.label1, foregroundColor: foregroundColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .inset(by: 0.5)
                    .stroke(Color.zetry(foregroundColor).opacity(0.7), lineWidth: 1)
                    .background(
                        .ultraThinMaterial.opacity(0.15),
                        in: RoundedRectangle(cornerRadius: 20, style: .continuous)
                    )
            )
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.bottom, 10)
    }
}

public struct ScrollOffsetKey: PreferenceKey {
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

public struct ObservableScrollView<Content>: View where Content: View {
    @Namespace var scrollSpace
    @Binding var scrollOffset: CGFloat
    let content: (ScrollViewProxy) -> Content

    public init(scrollOffset: Binding<CGFloat>,
                @ViewBuilder content: @escaping (ScrollViewProxy) -> Content)
    {
        _scrollOffset = scrollOffset
        self.content = content
    }

    public var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                content(proxy)
                    .background(GeometryReader { geo in
                        let offset = -geo.frame(in: .named(scrollSpace)).origin.y
                        Color.clear.preference(key: ScrollOffsetKey.self,
                                               value: offset)
                    })
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
