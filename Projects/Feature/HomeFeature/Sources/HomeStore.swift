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
        case onLoad
        case animatingList
        case indexChanged(Int)
        case cardChanged([Card])
        case toggleCategory
        case scrollOffsetYChanged(CGFloat)

        case categoryDataLoaded(TaskResult<[CategoryEntity]>)

        case routeToSearch
        case routeToLiving
        case livingSection(LivingSectionStore.Action)
    }

    @Dependency(\.categoryClient) private var categoryClient

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onLoad:
                return
                    .merge(
                        .run { send in
                            let result = await TaskResult {
                                try await categoryClient.fetchCategories()
                            }
                            await send(.categoryDataLoaded(result))
                        },
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
            case let .categoryDataLoaded(.success(result)):
                var categories = result.sorted(by: <)
                categories.insert(.init(title: "더보기", image: "", priority: 0), at: 4)
                state.categories = categories
                return .none
            default: return .none
            }
        }

        Scope(state: \.livingSectionStore, action: /Action.livingSection, child: {
            LivingSectionStore()
        })
    }
}
