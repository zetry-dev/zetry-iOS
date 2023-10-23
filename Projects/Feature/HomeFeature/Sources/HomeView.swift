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
    private let blurWidth: CGFloat = UIScreen.main.bounds.width
    private let blurHeight: CGFloat = UIScreen.main.bounds.height * 0.45

    public init(store: StoreOf<HomeStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            ObservableScrollView(
                scrollOffset: viewStore.binding(
                    get: \.scrollViewOffsetY,
                    send: HomeStore.Action.scrollOffsetYChanged
                )
            ) { _ in
                LazyVStack(
                    alignment: .leading,
                    spacing: 0,
                    pinnedViews: [.sectionHeaders],
                    content: {
                        Section {
                            VStack(alignment: .leading, spacing: 0) {
                                carouselView(viewStore: viewStore)
                                    .blurImageBackground(
                                        imageURL: viewStore.cards[viewStore.carouselCurrentIndex].imageURL,
                                        size: .init(width: blurWidth, height: blurHeight)
                                    )
                                    .padding(.top, 15)
                                VStack(alignment: .leading, spacing: 0) {
                                    categorySectionView(viewStore: viewStore)
                                    LivingSectionView(
                                        store: store.scope(
                                            state: \.livingSectionStore,
                                            action: HomeStore.Action.livingSection
                                        )
                                    )
                                    .padding(.vertical, 24)
                                }
                                .padding(.horizontal, 16)
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
            .edgesIgnoringSafeArea(.top)
            .onLoad {
                viewStore.send(.onLoad)
            }
            .onAppear {
                viewStore.send(.onAppear)
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
            carouselItem(viewStore: viewStore, imageURL: card.imageURL, args: (card, cardSize, index))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }

    @ViewBuilder
    private func carouselItem(
        viewStore: ViewStoreOf<HomeStore>,
        imageURL: String,
        args: (Card, CGSize, Int)
    ) -> some View {
        let (_, size, index) = args
        Image
            .load(imageURL, width: size.width)
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
                let item = viewStore.categories[safe: index] ?? .init()
                CategoryItemCell(
                    item.title,
                    imageUrl: item.imageURL,
                    size: 58
                )
                .animatedList(viewStore.isAnimated, index: index)
                .onTapGesture {
                    if index == 4 {
                        _ = withAnimation(.linear) {
                            viewStore.send(.toggleCategory)
                        }
                    } else {
                        viewStore.send(.routeToCategory(item.title))
                    }
                }
            }

            if viewStore.isCateogryExpandend {
                ForEach(5 ..< viewStore.categories.count, id: \.self) { index in
                    let item = viewStore.categories[safe: index] ?? .init()
                    CategoryItemCell(
                        item.title,
                        imageUrl: item.imageURL,
                        size: 58
                    )
                    .onTapGesture {
                        viewStore.send(.routeToCategory(item.title))
                    }
                }
            }
        }
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
