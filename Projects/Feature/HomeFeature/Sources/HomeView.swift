//
//  HomeView.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
import BaseFeature
import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct HomeView: View {
    public let store: StoreOf<HomeStore>
    private let categoryColumns: [GridItem] = Array(repeating: .init(.flexible(), alignment: .topLeading), count: 5)
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
                ZStack(alignment: .top) {
                    blurBackground(
                        imageURL: viewStore.banners[safe: viewStore.carouselCurrentIndex ?? 0]?.imageURL ?? "",
                        blurSize: .init(width: blurWidth, height: blurHeight)
                    )

                    LazyVStack(
                        alignment: .leading,
                        spacing: 0,
                        pinnedViews: [.sectionHeaders]
                    ) {
                        Section {
                            VStack(alignment: .leading, spacing: 0) {
                                VStack(alignment: .leading, spacing: 0) {
                                    carouselView(viewStore: viewStore)
                                        .padding(.top, 15)
                                        .padding(.bottom, 20)
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
                            }
                        } header: {
                            headerView(viewStore: viewStore)
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }

    @ViewBuilder
    private func blurBackground(imageURL: String, blurSize: CGSize) -> some View {
        Image.load(
            imageURL,
            width: blurSize.width,
            height: blurSize.height
        )
        .blur(radius: 100)
    }

    @ViewBuilder
    private func headerView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(spacing: 10) {
                DesignSystemAsset.Icons.zetryLogo.swiftUIImage
            }
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

    @ViewBuilder
    private func carouselView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        let bannerSize = UIScreen.main.bounds.width - 16
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(Array(viewStore.banners.enumerated()), id: \.element) { index, card in
                    carouselItem(card, viewStore: viewStore, index: index)
                        .id(index)
                        .onTapGesture {
                            viewStore.send(.routeToWebview(card.linkURL))
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: viewStore.binding(get: \.carouselCurrentIndex, send: HomeStore.Action.indexChanged))
        .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
        .scrollClipDisabled()
        .safeAreaPadding(.horizontal, 16)
        .frame(width: bannerSize, height: bannerSize)
        .aspectRatio(100 / 99, contentMode: .fit)
    }

    @ViewBuilder
    private func carouselItem(
        _ item: BannerEntity,
        viewStore: ViewStoreOf<HomeStore>,
        index: Int
    ) -> some View {
        Image
            .load(item.imageURL)
            .containerRelativeFrame([.horizontal, .vertical])
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .overlay(alignment: .leading) {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("#\(index + 1)")
                        Text(item.subtitle)
                    }
                    .fontStyle(.subtitle3, foregroundColor: .primary(.white))
                    .padding(.leading, 15)

                    Spacer()
                    Text(item.title)
                        .fontStyle(.subtitle2, foregroundColor: .primary(.white))
                        .padding(.leading, 30)
                }
                .padding(.vertical, 30)
            }
    }

    @ViewBuilder
    private func categorySectionView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        LazyVGrid(columns: categoryColumns, alignment: .leading) {
            ForEach(0 ..< 5, id: \.self) { index in
                let item = viewStore.categories[safe: index] ?? .init()
                CategoryItemCell(
                    item.title,
                    imageUrl: item.imageURL,
                    icon: index == 4 ? viewStore.cateogryExpandendIcon : nil,
                    size: 58
                ) {
                    if index == 4 {
                        _ = withAnimation(.linear) {
                            viewStore.send(.toggleCategory)
                        }
                    } else {
                        viewStore.send(.routeToCategory(item.title))
                    }
                }
                .animatedList(viewStore.isAnimated, index: index)
            }

            if viewStore.isCateogryExpandend {
                ForEach(5 ..< viewStore.categories.count, id: \.self) { index in
                    let item = viewStore.categories[safe: index] ?? .init()
                    CategoryItemCell(
                        item.title,
                        imageUrl: item.imageURL,
                        size: 58
                    ) {
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
            .padding(.horizontal, 16)
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
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
    }
}
