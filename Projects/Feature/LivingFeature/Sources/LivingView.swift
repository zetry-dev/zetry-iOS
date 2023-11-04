//
//  LivingView.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import DesignSystem
import SwiftUI

public struct LivingView: View {
    public let store: StoreOf<LivingStore>
    private let imageHeight: CGFloat = UIScreen.main.bounds.height * 0.45

    public init(store: StoreOf<LivingStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack {
                CollapsingScrollView(imageHeight: imageHeight) {
                    headerView(viewStore: viewStore)
                } titleView: {
                    Text("생활정보")
                        .fontStyle(.boldSubtitle1)
                } bannerView: {
                    bannerView(viewStore: viewStore)
                } backgroundView: {
                    imageView(url: viewStore.cards[viewStore.carouselCurrentIndex].imageURL)
                } contentView: {
                    contentView()
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .onLoad {
                viewStore.send(.onLoad)
            }
        }
    }

    @ViewBuilder
    private func bannerView(viewStore: ViewStoreOf<LivingStore>) -> some View {
        let selection = viewStore.binding(get: \.carouselCurrentIndex, send: LivingStore.Action.indexChanged)

        TabView(selection: selection) {
            ForEach(viewStore.cards.indices, id: \.self) { index in
                let card = viewStore.cards[index]
                imageView(url: card.imageURL)
                    .tag(index)
                    .onTapGesture {
                        viewStore.send(.routeToLivingDetail)
                    }
            }
        }
        .cornerRadius(6)
        .overlay(alignment: .bottomTrailing) {
            VStack(alignment: .trailing, spacing: 6) {
                let currentIndex = String(format: "%02d", viewStore.carouselCurrentIndex + 1)
                let totalIndex = String(format: "%02d", viewStore.cards.count)
                Text("\(currentIndex) / \(totalIndex)")
                    .fontStyle(.label3, foregroundColor: .primary(.white))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background {
                        Color.black
                            .opacity(0.4)
                            .cornerRadius(10, corners: [.topLeft])
                            .cornerRadius(4, corners: [.bottomRight])
                    }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }

    @ViewBuilder
    private func headerView(viewStore: ViewStoreOf<LivingStore>) -> some View {
        SegmentedPicker(
            viewStore.binding(
                get: { $0.selectedSegment },
                send: LivingStore.Action.selectedSegment
            ),
            segments: LivingSegementedTab.allCases,
            segmentStyle: .button(.style)
        )
    }

    @ViewBuilder
    private func contentView() -> some View {
        LivingSectionView(
            store: store.scope(
                state: \.livingSectionStore,
                action: LivingStore.Action.livingSection
            )
        )
        .padding(.horizontal, 16)
    }

    @ViewBuilder
    private func imageView(url urlString: String) -> some View {
        Image
            .load(urlString)
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("생활정보")
                        .fontStyle(.body1, foregroundColor: .primary(.white))
                    Text("친환경 제품을\n소개합니다")
                        .fontStyle(.headline3, foregroundColor: .primary(.white))
                }
                .padding(.leading, 30)
                .padding(.bottom, 30)
            }
            .onTapGesture {
                // TODO: - route to living detail
                print("route to living detail")
            }
    }
}
