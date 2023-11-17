//
//  LivingSectionStore.swift
//  BaseFeature
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import CoreKit
import Foundation
import LivingDomain

public struct LivingSectionStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public var livingSectionItems: [LivingSegementedTab: [LivingSectionItem]] = [LivingSegementedTab.home: []]
        public var selectedLivingTab: LivingSegementedTab
        var homeSectionItem: LivingSectionItem = .init()

        public init(selectedLivingTab: LivingSegementedTab = .home) {
            self.selectedLivingTab = selectedLivingTab
        }
    }

    public enum Action: Equatable {
        case view(View)
        case infoSection([LivingEntity])
        case todaySection([LivingEntity])
        case tipsSection([LivingEntity])
    }

    public var body: some ReducerOf<Self> {
        BindingReducer(action: /Action.view)

        Reduce { state, action in
            switch action {
            case let .infoSection(items):
                if state.selectedLivingTab == .home {
                    state.homeSectionItem.listSection = items
                } else {
                    state.livingSectionItems[LivingSegementedTab.livingInfo] = makeSectionItems(using: items)
                }
                return .none
            case let .todaySection(items):
                if state.selectedLivingTab == .home {
                    state.homeSectionItem.bannerSection = items[safe: 0]
                } else {
                    state.livingSectionItems[LivingSegementedTab.today] = makeSectionItems(using: items)
                }
                return .none
            case let .tipsSection(items):
                if state.selectedLivingTab == .home {
                    state.homeSectionItem.scrollSection = items
                } else {
                    state.livingSectionItems[LivingSegementedTab.tips] = makeSectionItems(using: items)
                }
                return .none
            default:
                return .none
            }
        }
    }

    private func makeSectionItems(using entity: [LivingEntity]) -> [LivingSectionItem] {
        entity.chunked(into: 8)
            .map { entity in
                let listSection = Array(entity.prefix(2))

                if entity.count > 2 {
                    let bannerSection = entity[safe: 2]
                    let scrollSection = entity[safe: 3 ..< entity.count] ?? []

                    return LivingSectionItem(
                        listSection: listSection,
                        bannerSection: bannerSection,
                        scrollSection: scrollSection
                    )
                } else {
                    return LivingSectionItem(
                        listSection: listSection,
                        bannerSection: nil,
                        scrollSection: []
                    )
                }
            }
    }
}

public extension LivingSectionStore.Action {
    enum View: Equatable, BindableAction {
        case binding(BindingAction<LivingSectionStore.State>)
        case routeToLiving(LivingSegementedTab)
        case routeToWebview(String)
    }
}
