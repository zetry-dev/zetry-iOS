//
//  CategoryView.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct CategoryView: View {
    public let store: StoreOf<CategoryStore>
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    public init(store: StoreOf<CategoryStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack(spacing: 0) {
                navigationView(viewStore: viewStore)

                SegmentedPicker(
                    viewStore.$selectedSegment,
                    segments: CategoryStore.CategorySegementedTab.allCases,
                    segmentStyle: .line(.style)
                )

                GeometryReader { proxy in
                    HStack(spacing: 0) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(viewStore.categories.indices, id: \.self) { index in
                                    let category = viewStore.categories[index]
                                    categoryView(
                                        category.title,
                                        selected: index == viewStore.selectedCategory
                                    )
                                    .onTapGesture {
                                        viewStore.send(.didTapCategory(index))
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: proxy.size.width * 0.35)

                        ScrollView {
                            if viewStore.selectedSegment == .recyclable {
                                LazyVGrid(columns: columns) {
                                    ForEach(0 ... 19, id: \.self) { _ in
                                        CategoryItemCell(
                                            "재활용",
                                            imageUrl: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg",
                                            size: 62
                                        )
                                    }
                                }
                                .padding(.vertical, 18)
                                .padding(.horizontal, 13)
                            } else {
                                LazyVGrid(columns: columns) {
                                    ForEach(0 ... 19, id: \.self) { _ in
                                        CategoryItemCell(
                                            "일반",
                                            imageUrl: "https://p7.hiclipart.com/preview/180/516/952/apple-logo-computer-icons-clip-art-iphone-apple.jpg",
                                            size: 62
                                        )
                                    }
                                }
                                .padding(.vertical, 18)
                                .padding(.horizontal, 13)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.zetry(.grayScale(.gray0)))
            }
            .onLoad {
                viewStore.send(.onLoad)
            }
        }
    }

    @ViewBuilder
    private func navigationView(viewStore: ViewStoreOf<CategoryStore>) -> some View {
        HStack {
            Text("카테고리")
                .fontStyle(.subtitle2)
        }
        .frame(maxWidth: .infinity, maxHeight: 38)
        .overlay(alignment: .trailing) {
            Button {
                viewStore.send(.routeToSearch)
            } label: {
                ZetryIcon(DesignSystemAsset.Icons.magnifyingglass, size: .larger)
                    .padding(.trailing, 16)
            }
        }
    }

    @ViewBuilder
    private func categoryView(_ category: String, selected: Bool) -> some View {
        Text(category)
            .fontStyle(
                selected ? .subtitle4 : .body2,
                foregroundColor: selected ? .grayScale(.gray12) : .grayScale(.gray5)
            )
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 56)
            .contentShape(Rectangle())
            .background(selected ? Color.zetry(.grayScale(.gray0)) : Color.white)
    }
}
