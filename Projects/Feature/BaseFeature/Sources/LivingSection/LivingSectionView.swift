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
                if viewStore.selectedLivingTab == .home {
                    homeSection(viewStore: viewStore, item: viewStore.homeSectionItem)
                } else {
                    let sectionItems = viewStore.livingSectionItems[viewStore.selectedLivingTab] ?? []
                    livingSection(viewStore: viewStore, items: sectionItems)
                }
            }
        }
    }

    @ViewBuilder
    private func homeSection(
        viewStore: ViewStore<LivingSectionView.ViewState, LivingSectionStore.Action.View>,
        item: LivingSectionItem
    ) -> some View {
        livingSectionListView(viewStore: viewStore, items: item.listSection)
        livingSectionBannerView(viewStore: viewStore, item: item.bannerSection)
        livingSectionHorizontalScrollView(viewStore: viewStore, items: item.scrollSection)
    }

    @ViewBuilder
    private func livingSection(
        viewStore: ViewStore<LivingSectionView.ViewState, LivingSectionStore.Action.View>,
        items: [LivingSectionItem]
    ) -> some View {
        ForEach(items, id: \.self) { item in
            livingSectionListView(viewStore: viewStore, items: item.listSection)
            livingSectionBannerView(viewStore: viewStore, item: item.bannerSection)
            livingSectionHorizontalScrollView(viewStore: viewStore, items: item.scrollSection)
        }
    }

    @ViewBuilder
    private func livingSectionListView(
        viewStore: ViewStore<LivingSectionView.ViewState, LivingSectionStore.Action.View>,
        items: [LivingEntity]
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if viewStore.selectedLivingTab == .home {
                HStack(spacing: 6) {
                    Text("생활정보")
                        .fontStyle(.subtitle1)
                    ZetryIcon(DesignSystemAsset.Icons.chevronRight)
                }
                .padding(.vertical, 16)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewStore.send(.routeToLiving(.livingInfo))
                }
            }

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
        item: LivingEntity?
    ) -> some View {
        if let item {
            VStack(alignment: .leading, spacing: 0) {
                if viewStore.selectedLivingTab == .home {
                    HStack(spacing: 6) {
                        Text("오늘의 추천상점")
                            .fontStyle(.subtitle1)
                        ZetryIcon(DesignSystemAsset.Icons.chevronRight)
                    }
                    .padding(.vertical, 16)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewStore.send(.routeToLiving(.today))
                    }
                }

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
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func livingSectionHorizontalScrollView(
        viewStore: ViewStore<LivingSectionView.ViewState, LivingSectionStore.Action.View>,
        items: [LivingEntity]
    ) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if viewStore.selectedLivingTab == .home {
                HStack(spacing: 6) {
                    Text("알면 좋은 꿀팁")
                        .fontStyle(.subtitle1)
                    ZetryIcon(DesignSystemAsset.Icons.chevronRight)
                }
                .padding(.vertical, 16)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewStore.send(.routeToLiving(.tips))
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
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
        var livingSectionItems: [LivingSegementedTab: [LivingSectionItem]]
        var selectedLivingTab: LivingSegementedTab
        var homeSectionItem: LivingSectionItem
    }
}

extension BindingViewStore<LivingSectionStore.State> {
    var view: LivingSectionView.ViewState {
        LivingSectionView.ViewState(
            livingSectionItems: self.livingSectionItems,
            selectedLivingTab: self.selectedLivingTab,
            homeSectionItem: self.homeSectionItem
        )
    }
}
