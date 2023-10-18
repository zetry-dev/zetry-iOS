//
//  LivingSectionView.swift
//  BaseFeature
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import DesignSystem
import LivingDomainInterface
import SwiftUI

public struct LivingSectionView: View {
    private let store: StoreOf<LivingSectionStore>

    public init(store: StoreOf<LivingSectionStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: \.view, send: LivingSectionStore.Action.view) { viewStore in
            VStack(alignment: .leading, spacing: 14) {
                let sectionItems = viewStore.livingSectionItems[viewStore.selectedLivingTab.rawValue] ?? []
                ForEach(sectionItems, id: \.self) { item in
                    livingSectionListView(viewStore: viewStore, items: item.listSection)
                    livingSectionBannerView(viewStore: viewStore, item: item.bannerSection)
                    livingSectionHorizontalScrollView(viewStore: viewStore, items: item.scrollSection)
                }
            }
        }
    }

    @ViewBuilder
    private func livingSectionListView(
        viewStore: ViewStore<LivingSectionView.ViewState, LivingSectionStore.Action.View>,
        items: [LivingEntity]
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("생활정보")
                .fontStyle(.subtitle1)
                .padding(.vertical, 16)

            VStack(alignment: .leading, spacing: 18) {
                ForEach(items, id: \.self) { item in
                    LivingListItemCell(
                        item.title,
                        subtitle: item.subtitle,
                        imageURL: item.imageURL
                    )
                    .onTapGesture {
                        viewStore.send(.routeToLivingDetail(item.linkURL))
                    }
                }
            }
            .padding(.top, 10)
        }
    }

    @ViewBuilder
    private func livingSectionBannerView(
        viewStore: ViewStore<LivingSectionView.ViewState, LivingSectionStore.Action.View>,
        item: LivingEntity
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("오늘의 추천상점")
                .fontStyle(.subtitle1)
                .padding(.vertical, 16)

            LivingBannerItemCell(
                item.title,
                subtitle: item.subtitle,
                imageURL: item.imageURL
            )
            .padding(.top, 10)
            .onTapGesture {
                viewStore.send(.routeToLivingDetail(item.linkURL))
            }
        }
    }

    @ViewBuilder
    private func livingSectionHorizontalScrollView(
        viewStore: ViewStore<LivingSectionView.ViewState, LivingSectionStore.Action.View>,
        items: [LivingEntity]
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("알면 좋은 꿀팁")
                .fontStyle(.subtitle1)
                .padding(.vertical, 16)

            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(items, id: \.self) { item in
                        LivingScrollItemCell(
                            item.title,
                            subtitle: item.subtitle,
                            imageURL: item.imageURL
                        )
                        .onTapGesture {
                            viewStore.send(.routeToLivingDetail(item.linkURL))
                        }
                    }
                }
                .padding(.top, 10)
            }
        }
    }
}

extension LivingSectionView {
    struct ViewState: Equatable {
        var livingSectionItems: [Int: [LivingSectionItem]]
        var selectedLivingTab: LivingSegementedTab
    }
}

extension BindingViewStore<LivingSectionStore.State> {
    var view: LivingSectionView.ViewState {
        LivingSectionView.ViewState(
            livingSectionItems: self.livingSectionItems,
            selectedLivingTab: self.selectedLivingTab
        )
    }
}
