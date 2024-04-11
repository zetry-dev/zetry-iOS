//
//  HomeStore.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseDomainInterface
import BaseFeature
import CategoryDomain
import ComposableArchitecture
import DesignSystem
import HomeDomain
import LivingDomain
import TCACoordinators
import UIKit

public struct HomeStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var livingSectionStore: LivingSectionStore.State = .init()
        var banners: [BannerEntity] = []
        var categories: [CategoryEntity] = []
        var isCateogryExpandend: Bool = false
        var cateogryExpandendIcon: DesignSystemImages {
            isCateogryExpandend ? DesignSystemAsset.Icons.chevronUpCircle : DesignSystemAsset.Icons.chevronDownCircle
        }

        var isAnimated: Bool = false
        var carouselCurrentIndex: Int? = 0
        var scrollViewOffsetY: CGFloat = 0.0

        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
        case animatingList
        case indexChanged(Int?)
        case cardChanged([BannerEntity])
        case toggleCategory
        case scrollOffsetYChanged(CGFloat)

        case fetchBanners
        case fetchCategories
        case fetchInformation
        case fetchToday
        case fetchTips

        case bannerDataLoaded(TaskResult<[BannerEntity]>)
        case categoryDataLoaded(TaskResult<[CategoryEntity]>)
        case informationDataLoaded(TaskResult<[LivingEntity]>)
        case todayDataLoaded(TaskResult<[LivingEntity]>)
        case tipsDataLoaded(TaskResult<[LivingEntity]>)

        case routeToCategory(String)
        case routeToSearch
        case routeToLiving(LivingSegementedTab)
        case routeToWebview(String)

        case livingSection(LivingSectionStore.Action)
    }

    @Dependency(\.homeClient) private var homeClient
    @Dependency(\.categoryClient) private var categoryClient
    @Dependency(\.livingClient) private var livingClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return
                    .merge(
                        .send(.fetchBanners),
                        .send(.fetchCategories),
                        .send(.fetchInformation),
                        .send(.animatingList)
                    )
                
            case .animatingList:
                state.isAnimated = true

            case let .indexChanged(index):
                state.carouselCurrentIndex = index

            case .toggleCategory:
                state.isCateogryExpandend.toggle()
                state.categories[4].title = state.isCateogryExpandend ? "접기" : "더보기"

            case let .scrollOffsetYChanged(offsetY):
                state.scrollViewOffsetY = offsetY

            case .fetchBanners:
                return .run { send in
                    let result = await TaskResult {
                        try await homeClient.fetchMainBannerItems()
                    }
                    await send(.bannerDataLoaded(result))
                }
            case .fetchCategories:
                return .run { send in
                    let result = await TaskResult {
                        try await categoryClient.fetchCategories()
                    }
                    await send(.categoryDataLoaded(result))
                }
                
            case .fetchInformation:
                return .concatenate(
                    .run { send in
                        let result = await TaskResult {
                            try await livingClient.fetchLivingItems("information")
                        }
                        await send(.informationDataLoaded(result))
                    },
                    .send(.fetchToday),
                    .send(.fetchTips)
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
                state.banners = result.sorted(by: <)

            case let .categoryDataLoaded(.success(result)):
                var categories = result.sorted(by: <)
                categories.insert(.init(title: "더보기", image: "", priority: 0), at: 4)
                state.categories = categories

            case let .informationDataLoaded(.success(result)):
                return .send(.livingSection(.infoSection(Array(result.prefix(2)))))
                
            case let .todayDataLoaded(.success(result)):
                return .send(.livingSection(.todaySection(Array(result.prefix(1)))))
                
            case let .tipsDataLoaded(.success(result)):
                return .send(.livingSection(.tipsSection(Array(result.prefix(5)))))

            case let .livingSection(.view(.routeToLiving(livingSection))):
                return .send(.routeToLiving(livingSection))
                
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
