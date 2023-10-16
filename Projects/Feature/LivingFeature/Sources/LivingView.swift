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
    private let imageHeight: CGFloat = UIScreen.main.bounds.height * 0.55

    public init(store: StoreOf<LivingStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack {
                CollapsingScrollView(imageHeight: imageHeight) {
                    headerView(viewStore: viewStore)
                } bannerView: {
                    bannerView(viewStore: viewStore)
                } backgroundView: {
                    imageView(url: viewStore.cards[viewStore.carouselCurrentIndex].imageURL)
                } contentView: {
                    contentView()
                }
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
        let imageURL = URL(string: urlString)

        CachedAsyncImage(url: imageURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Color
                    .zetry(.grayScale(.gray3))
            }
        }
    }
}
