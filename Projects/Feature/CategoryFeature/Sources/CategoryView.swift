//
//  CategoryView.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import BaseFeatureInterface
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
                    paddingHorizontal: 23.5
                )

                GeometryReader { proxy in
                    HStack(spacing: 0) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(ZetryCategory.allCases, id: \.self) { category in
                                    categoryView(
                                        category,
                                        selected: category == viewStore.selectedCategory
                                    )
                                    .onTapGesture {
                                        viewStore.send(.didTapCategory(category))
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
                                            size: 62,
                                            imageUrl: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"
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
                                            size: 62,
                                            imageUrl: "https://p7.hiclipart.com/preview/180/516/952/apple-logo-computer-icons-clip-art-iphone-apple.jpg"
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
    private func categoryView(_ category: ZetryCategory, selected: Bool) -> some View {
        Text(category.rawValue)
            .fontStyle(
                selected ? .subtitle3 : .body2,
                foregroundColor: selected ? .grayScale(.gray12) : .grayScale(.gray5)
            )
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 56)
            .contentShape(Rectangle())
            .background(selected ? Color.zetry(.grayScale(.gray0)) : Color.white)
    }
}
