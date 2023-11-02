//
//  LivingStore.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import CoreKit
import CoreKitInterface
import DesignSystem
import Foundation
import LivingDomain
import LivingDomainInterface

public struct LivingStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var livingSectionStore: LivingSectionStore.State = .init()
        var selectedSegment: LivingSegementedTab = .livingInfo
        var segmentedTab: [LivingSegementedTab] = LivingSegementedTab.allCases
        var carouselCurrentIndex: Int = 0
        var scrollViewOffsetY: CGFloat = 0.0
        // test
        var cards: [Card] = [
            .init(title: "카드1", color: .red, imageURL: "https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg"),
            .init(title: "카드2", color: .blue, imageURL: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg"),
            .init(title: "카드3", color: .green, imageURL: "https://img.freepik.com/premium-photo/image-colorful-galaxy-sky-generative-ai_791316-9864.jpg"),
            .init(title: "카드4", color: .pink, imageURL: "https://i.pinimg.com/564x/35/4a/a8/354aa89fa2365b813031fb75d9f548e0.jpg")
        ]

        public init(selectedLiving: LivingSegementedTab) {
            self.selectedSegment = selectedLiving
        }
    }

    public enum Action: Equatable {
        case onLoad
        case selectedSegment(LivingSegementedTab)
        case livingSection(LivingSectionStore.Action)
        case indexChanged(Int)
        case cardChanged([Card])

        case fetchInformation
        case fetchToday
        case fetchTips

        case informationDataLoaded(TaskResult<[LivingEntity]>)
        case todayDataLoaded(TaskResult<[LivingEntity]>)
        case tipsDataLoaded(TaskResult<[LivingEntity]>)

        case routeToLivingDetail
    }

    @Dependency(\.livingClient) private var livingClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onLoad:
                return .send(.fetchInformation)
            case let .selectedSegment(segment):
                state.selectedSegment = segment
                state.livingSectionStore.selectedLivingTab = segment
                return .none
            case let .indexChanged(index):
                state.carouselCurrentIndex = index
                return .none
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
            case let .informationDataLoaded(.success(result)):
                state.livingSectionStore.selectedLivingTab = .livingInfo
                return .send(.livingSection(.infoSection(result)))
            case let .todayDataLoaded(.success(result)):
                return .send(.livingSection(.todaySection(result)))
            case let .tipsDataLoaded(.success(result)):
                return .send(.livingSection(.tipsSection(result)))
            default:
                return .none
            }
        }

        Scope(state: \.livingSectionStore, action: /Action.livingSection, child: {
            LivingSectionStore()._printChanges()
        })
    }
}
