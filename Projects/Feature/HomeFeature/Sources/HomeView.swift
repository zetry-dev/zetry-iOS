//
//  HomeView.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct HomeView: View {
    public let store: StoreOf<HomeStore>
    private let livingColumns: [GridItem] = [.init(.flexible(), spacing: 12), .init(.flexible(), spacing: 12)]
    private let categoryColumns: [GridItem] = Array(repeating: .init(.flexible(), alignment: .top), count: 5)
    private let gradientHeight: CGFloat = UIScreen.main.bounds.height * 0.55

    @State var cards: [Card] = [.init(title: "카드1", color: .red), .init(title: "카드2", color: .blue), .init(title: "카드3", color: .green), .init(title: "카드4", color: .pink)]

    @State var currentIndex: Int = 0

    public init(store: StoreOf<HomeStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                // TODO: -로고 반영
                Text("zetry")
                    .fontStyle(
                        .subtitle1,
                        foregroundColor: .grayScale(.white)
                    )
                    .padding(.leading, 16)
                    .padding(.bottom, 16)

                searchNavigationView()
                    .onTapGesture {
                        viewStore.send(.routeToSearch)
                    }

                ScrollView {
                    CarouselView(index: $currentIndex, items: $cards, spacing: 16, cardPadding: 64) { _, cardSize in
                        CachedAsyncImage(
                            url: URL(string: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg")
                        ) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: cardSize.width)
                            default:
                                Color
                                    .zetry(.grayScale(.gray3))
                                    .frame(width: cardSize.width, height: 333)
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .frame(height: 333)
                }
                .padding(.top, 15)
            }
            .gradientBackground(height: gradientHeight)
            .onAppear {
                viewStore.send(.animatingList)
            }
        }
    }

    @ViewBuilder
    private func categorySectionView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        LazyVGrid(columns: categoryColumns) {
            ForEach(viewStore.categories.indices, id: \.self) { index in
                CategoryItemCell(
                    viewStore.categories[index].rawValue,
                    size: 54,
                    imageUrl: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
                )
                .animatedList(viewStore.isAnimated, index: index)
            }
        }
        .padding(.top, 26)
    }

    @ViewBuilder
    private func livingSectionView(viewStore: ViewStoreOf<HomeStore>) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("생활정보")
                .fontStyle(.subtitle3)

            LazyVGrid(
                columns: livingColumns,
                spacing: 28
            ) {
                ForEach(0 ... 9, id: \.self) { index in
                    LivingItemCell(
                        "쓰레기 잘 버리는 법",
                        imageUrl: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
                    )
                    .animatedList(viewStore.isAnimated, index: index)
                    .onTapGesture {
                        viewStore.send(.routeToLiving)
                    }
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 15)
    }

    @ViewBuilder
    private func gradientBackground() -> some View {}

    @ViewBuilder
    private func searchNavigationView() -> some View {
        HStack {
            HStack(spacing: 10) {
                ZetryIcon(
                    DesignSystemAsset.Icons.magnifyingglass,
                    foregroundColor: .grayScale(.white),
                    size: .larger
                )

                Text("분리수거 방법이 궁금한 쓰레기를 검색해보세요.")
                    .fontStyle(.label1, foregroundColor: .grayScale(.white))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .inset(by: 0.5)
                    .stroke(.white.opacity(0.7), lineWidth: 1)
                    .background(
                        .ultraThinMaterial.opacity(0.15),
                        in: RoundedRectangle(cornerRadius: 20, style: .continuous)
                    )
            )
            Spacer()
        }
        .padding(.leading, 16)
    }
}
