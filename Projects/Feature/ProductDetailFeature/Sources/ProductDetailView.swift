//
//  ProductDetailView.swift
//  ProductDetailFeature
//
//  Created by AllieKim on 2023/08/29.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import DesignSystem
import ProductDomain
import SwiftUI

public struct ProductDetailView: View {
    public let store: StoreOf<ProductDetailStore>

    public init(store: StoreOf<ProductDetailStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            let product = viewStore.item

            VStack(alignment: .leading, spacing: 0) {
                ObservableScrollView(
                    scrollOffset: viewStore.binding(
                        get: \.scrollViewOffsetY,
                        send: ProductDetailStore.Action.scrollOffsetYChanged
                    )
                ) { _ in
                    GeometryReader { proxy in
                        productImageView(
                            url: product.imageURL,
                            imageHeight: viewStore.imageHeight,
                            proxy: proxy
                        )
                    }
                    .frame(height: viewStore.imageHeight)
                    detailContentView(viewStore: viewStore)
                        .offset(y: -40)
                }
            }
            .background(.regularMaterial)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(product.title)
                        .fontStyle(.subtitle2)
                        .opacity(viewStore.scrollViewOffsetY > 300 ? 1 : 0)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        viewStore.send(.pop)
                    } label: {
                        ZetryIcon(DesignSystemAsset.Icons.chevronLeft)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewStore.send(.popToRoot)
                    } label: {
                        ZetryIcon(DesignSystemAsset.Icons.house)
                    }
                }
            }
            .onLoad {
                viewStore.send(.onLoad)
            }
        }
    }

    @ViewBuilder
    func productImageView(
        url: String,
        imageHeight: CGFloat,
        proxy: GeometryProxy
    ) -> some View {
        let offsetY = proxy.frame(in: .global).minY > 0 ? -proxy.frame(in: .global).minY : 0
        let height = proxy.frame(in: .global).minY > 0 ? imageHeight + proxy.frame(in: .global).minY : imageHeight

        Image
            .load(url, width: UIScreen.main.bounds.width)
            .offset(y: offsetY)
            .frame(height: height, alignment: .center)
    }

    @ViewBuilder
    private func detailChips(
        recyclable: Bool,
        isTrash: Bool
    ) -> some View {
        HStack(spacing: 8) {
            DetailChip(
                text: recyclable ? "재활용 가능" : "재활용 불가능",
                icon: recyclable ? DesignSystemAsset.Icons.arrow3Trianglepath : nil
            )
            if isTrash {
                DetailChip(text: "일반 쓰레기")
            }
            Spacer()
        }
        .padding(.horizontal, 28)
        .padding(.top, 5)
        .padding(.bottom, 10)
    }

    @ViewBuilder
    func detailContentView(viewStore: ViewStoreOf<ProductDetailStore>) -> some View {
        let product = viewStore.item
        let recommendItems = viewStore.recommendedItems
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 8) {
                Text(product.category)
                    .fontStyle(.body3)
                Text(product.title)
                    .fontStyle(.headline1)
            }
            .padding(.leading, 28)

            Divider(color: .primary(.black), opacity: 0.05)

            detailChips(
                recyclable: product.recyclable,
                isTrash: product.isTrash
            )

            Text("버리는 방법")
                .fontStyle(.subtitle1)
                .padding(.leading, 30)

            VStack(alignment: .leading, spacing: 18) {
                ForEach(product.description, id: \.self) { description in
                    BulletText(description)
                }

                if let notice = product.notice {
                    HStack(alignment: .top, spacing: 8) {
                        ZetryIcon(DesignSystemAsset.Icons.exclamationmarkCircleSmall,
                                  foregroundColor: .primary(.primary))
                            .padding(.top, 4)
                            .padding(.leading, -8)
                        MultilineText(notice, font: .label1, foregroudColor: .grayScale(.gray8))
                            .fontWithLineHeight(font: Font.zetry(.label1), lineHeight: 28)
                    }
                }
            }
            .padding(.top, 8)
            .padding(.bottom, 9)
            .padding(.horizontal, 30)

            Divider(color: .grayScale(.gray2))

            VStack(alignment: .leading) {
                Text("이런 쓰레기는 어떠세요?")
                    .fontStyle(.subtitle2)
                    .padding(.bottom, 26)
                    .padding(.horizontal, 30)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 18) {
                        ForEach(recommendItems, id: \.self) { recommendItem in
                            CategoryItemCell(recommendItem.title, imageURL: recommendItem.imageURL, size: 72) {
                                viewStore.send(.routeToDetail(item: recommendItem))
                            }
                            .frame(width: 72)
                        }
                    }
                    .padding(.leading, 30)
                }
            }
            .padding(.top, 20)
        }
        .padding(.top, 26)
        .background(.regularMaterial)
        .border(width: 1, edges: [.top], color: .white.opacity(0.8))
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}
