//
//  LivingStore.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
import BaseFeature
import ComposableArchitecture
import CoreKit
import CoreKitInterface
import Foundation
import LivingDomain

public struct LivingStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var livingSectionStore: LivingSectionStore.State = .init()
        var selectedSegment: LivingSegementedTab = .livingInfo
        var segmentedTab: [LivingSegementedTab] = LivingSegementedTab.allCases
        var carouselCurrentIndex: Int = 0
        var scrollViewOffsetY: CGFloat = 0.0
        var banners: [BannerEntity] = []

        public init(selectedLiving: LivingSegementedTab) {
            self.selectedSegment = selectedLiving
            self.livingSectionStore = .init(selectedLivingTab: selectedLiving)
        }
    }

    public enum Action: Equatable {
        case onLoad
        case scrollOffsetYChanged(CGFloat)
        case selectedSegment(LivingSegementedTab)
        case livingSection(LivingSectionStore.Action)
        case indexChanged(Int)
        case cardChanged([BannerEntity])

        case fetchBanners
        case fetchInformation
        case fetchToday
        case fetchTips

        case bannerDataLoaded(TaskResult<[BannerEntity]>)
        case informationDataLoaded(TaskResult<[LivingEntity]>)
        case todayDataLoaded(TaskResult<[LivingEntity]>)
        case tipsDataLoaded(TaskResult<[LivingEntity]>)

        case routeToWebview(String)
    }

    @Dependency(\.livingClient) private var livingClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onLoad:
                return .concatenate(
                    .send(.fetchBanners),
                    .send(.fetchInformation),
                    .send(.fetchToday),
                    .send(.fetchTips)
                )

            case let .scrollOffsetYChanged(offsetY):
                state.scrollViewOffsetY = offsetY

            case let .selectedSegment(segment):
                state.selectedSegment = segment
                state.livingSectionStore.selectedLivingTab = segment

            case let .indexChanged(index):
                state.carouselCurrentIndex = index

            case .fetchBanners:
                return .run { send in
                    let result = await TaskResult {
                        try await livingClient.fetchLivingBannerItems()
                    }
                    await send(.bannerDataLoaded(result))
                }

            case .fetchInformation:
                return .concatenate(
                    .run { send in
                        let result = await TaskResult {
                            try await livingClient.fetchLivingItems("information")
                        }
                        await send(.informationDataLoaded(result))
                    }
                )

            case .fetchToday:
                return .run { send in
                    let result = await TaskResult {
                        try await livingClient.fetchLivingItems("today")
                    }
                    await send(.todayDataLoaded(result))
                }

            case .fetchTips:
                return .run { send in
                    let result = await TaskResult {
                        try await livingClient.fetchLivingItems("tips")
                    }
                    await send(.tipsDataLoaded(result))
                }

            case let .bannerDataLoaded(.success(result)):
                state.banners = result

            case let .informationDataLoaded(.success(result)):
                return .send(.livingSection(.infoSection(result)))

            case let .todayDataLoaded(.success(result)):
                return .send(.livingSection(.todaySection(result)))

            case let .tipsDataLoaded(.success(result)):
                return .send(.livingSection(.tipsSection(result)))

            case let .livingSection(.view(.routeToWebview(urlString))):
                return .send(.routeToWebview(urlString))

            default:
                return .none
            }
            return .none
        }

        Scope(state: \.livingSectionStore, action: /Action.livingSection, child: {
            LivingSectionStore()
        })
    }
}
