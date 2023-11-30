//
//  LivingView.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
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
            ObservableScrollView(
                scrollOffset: viewStore.binding(
                    get: \.scrollViewOffsetY,
                    send: LivingStore.Action.scrollOffsetYChanged
                )
            ) { proxy in
                bannerView(viewStore: viewStore)
                    .id("top")

                LazyVStack(
                    alignment: .leading,
                    spacing: 0,
                    pinnedViews: [.sectionHeaders],
                    content: {
                        Section {
                            VStack(alignment: .leading, spacing: 0) {
                                contentView()
                            }
                        } header: {
                            headerView(viewStore: viewStore)
                                .background(
                                    .thinMaterial.opacity(viewStore.scrollViewOffsetY < 370 ? 0 : 1)
                                )
                        }
                    }
                )
                .onChange(of: viewStore.selectedSegment) { _ in
                    withAnimation {
                        proxy.scrollTo("top", anchor: .top)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
            .toolbar(.hidden, for: .navigationBar)
            .onLoad {
                viewStore.send(.onLoad)
            }
        }
    }

    @ViewBuilder
    private func bannerView(viewStore: ViewStoreOf<LivingStore>) -> some View {
        let selection = viewStore.binding(get: \.carouselCurrentIndex, send: LivingStore.Action.indexChanged)
        let background = viewStore.banners[safe: viewStore.carouselCurrentIndex]

        ZStack {
            imageView(viewStore: viewStore, banner: background)
                .blur(radius: 10)
            VStack(alignment: .leading, spacing: 20) {
                Text("생활정보")
                    .fontStyle(.boldSubtitle1)
                ZStack(alignment: .bottomTrailing) {
                    TabView(selection: selection) {
                        ForEach(viewStore.banners.indices, id: \.self) { index in
                            let item = viewStore.banners[safe: index]
                            imageView(viewStore: viewStore, banner: item)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 300)

                    VStack(alignment: .trailing, spacing: 6) {
                        carouselIndexView(viewStore)
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
                .cornerRadius(6)
            }
            .padding(.top, 50)
            .padding(.horizontal, 16)
        }
    }

    @ViewBuilder
    private func carouselIndexView(_ viewStore: ViewStoreOf<LivingStore>) -> some View {
        let currentIndex = String(format: "%02d", viewStore.carouselCurrentIndex + 1)
        let totalIndex = String(format: "%02d", viewStore.banners.count)

        Text("\(currentIndex) / \(totalIndex)") { string in
            string.foregroundColor = .white
            string.font = Font.zetry(.label3)
            if let range = string.range(of: "/ \(totalIndex)") {
                string[range].foregroundColor = Color.zetry(.grayScale(.gray2)).opacity(0.7)
                string.font = Font.zetry(.label3)
            }
        }
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
        .padding(.vertical, 16)
        .padding(.top, viewStore.scrollViewOffsetY < 370 ? 0 : 50)
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
    private func imageView(viewStore: ViewStoreOf<LivingStore>, banner: BannerEntity?) -> some View {
        if let banner {
            Image
                .load(banner.imageURL)
                .overlay(alignment: .bottomLeading) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(banner.title)
                            .fontStyle(.body2, foregroundColor: .primary(.white))
                        Text(banner.subtitle)
                            .fontStyle(.headline3, foregroundColor: .primary(.white))
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, 30)
                }
                .onTapGesture {
                    viewStore.send(.routeToWebview(banner.linkURL))
                }
        }
    }
}
