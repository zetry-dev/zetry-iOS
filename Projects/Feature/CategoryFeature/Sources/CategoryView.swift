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
    private var columns: [GridItem] = Array(repeating: .init(.flexible(), alignment: .top), count: 3)

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
                        ScrollView(showsIndicators: false) {
                            VStack(alignment: .leading, spacing: 0) {
                                ForEach(viewStore.categories, id: \.self) { category in
                                    categoryView(
                                        category.title,
                                        selected: category.title == viewStore.selectedCategory
                                    )
                                    .onTapGesture {
                                        viewStore.send(.didTapCategory(category.title))
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: proxy.size.width * 0.35)
                        .background(Color.white)

                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: columns) {
                                ForEach(viewStore.selectedProducts, id: \.self) { product in
                                    CategoryItemCell(
                                        product.title,
                                        imageURL: product.imageURL,
                                        size: 62
                                    ) {
                                        viewStore.send(.routeToProductDetail(product))
                                    }
                                }
                            }
                            .padding(.vertical, 18)
                            .padding(.horizontal, 13)
                            .animation(.none, value: UUID())
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
                selected ? .subtitle4 : .label1,
                foregroundColor: selected ? .grayScale(.gray12) : .grayScale(.gray5)
            )
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 60)
            .contentShape(Rectangle())
            .background(selected ? Color.zetry(.grayScale(.gray0)) : Color.white)
    }
}
