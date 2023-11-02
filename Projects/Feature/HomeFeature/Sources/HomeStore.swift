//
//  HomeStore.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import CategoryDomain
import CategoryDomainInterface
import ComposableArchitecture
import DesignSystem
import LivingDomain
import LivingDomainInterface
import TCACoordinators
import UIKit

public struct HomeStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var livingSectionStore: LivingSectionStore.State = .init()
        var categories: [CategoryEntity] = []
        var isCateogryExpandend: Bool = false

        var isAnimated: Bool = false
        var carouselCurrentIndex: Int = 0
        var scrollViewOffsetY: CGFloat = 0.0
        // test
        var cards: [Card] = [
            .init(title: "카드1", color: .red, imageURL: "https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg"),
            .init(title: "카드2", color: .blue, imageURL: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"),
            .init(title: "카드3", color: .green, imageURL: "https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg"),
            .init(title: "카드4", color: .pink, imageURL: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg")
        ]

        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
        case animatingList
        case indexChanged(Int)
        case cardChanged([Card])
        case toggleCategory
        case scrollOffsetYChanged(CGFloat)

        case fetchCategories
        case fetchInformation
        case fetchToday
        case fetchTips

        case categoryDataLoaded(TaskResult<[CategoryEntity]>)
        case informationDataLoaded(TaskResult<[LivingEntity]>)
        case todayDataLoaded(TaskResult<[LivingEntity]>)
        case tipsDataLoaded(TaskResult<[LivingEntity]>)

        case routeToCategory(String)
        case routeToSearch
        case routeToLiving(LivingSegementedTab)
        case livingSection(LivingSectionStore.Action)
    }

    @Dependency(\.categoryClient) private var categoryClient
    @Dependency(\.livingClient) private var livingClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return
                    .merge(
                        .send(.fetchCategories),
                        .send(.fetchInformation),
                        .send(.animatingList)
                    )
            case .animatingList:
                state.isAnimated = true
                return .none
            case let .indexChanged(index):
                state.carouselCurrentIndex = index
                return .none
            case .toggleCategory:
                state.isCateogryExpandend.toggle()
                state.categories[4].title = state.isCateogryExpandend ? "접기" : "더보기"
                return .none
            case let .scrollOffsetYChanged(offsetY):
                state.scrollViewOffsetY = offsetY
                return .none
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
            case let .categoryDataLoaded(.success(result)):
                var categories = result.sorted(by: <)
                categories.insert(.init(title: "더보기", image: "", priority: 0), at: 4)
                state.categories = categories
                return .none
            case let .informationDataLoaded(.success(result)):
                return .send(.livingSection(.infoSection(Array(result.prefix(2)))))
            case let .todayDataLoaded(.success(result)):
                return .send(.livingSection(.todaySection(Array(result.prefix(1)))))
            case let .tipsDataLoaded(.success(result)):
                return .send(.livingSection(.tipsSection(Array(result.prefix(5)))))
            case let .livingSection(.view(.routeToLiving(livingSection))):
                return .send(.routeToLiving(livingSection))
            default: return .none
            }
        }

        Scope(state: \.livingSectionStore, action: /Action.livingSection, child: {
            LivingSectionStore()
        })
    }
}
