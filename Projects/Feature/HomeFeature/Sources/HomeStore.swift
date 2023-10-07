//
//  HomeStore.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import DesignSystem
import TCACoordinators

public struct HomeStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var categories: [ZetryCategory] = ZetryCategory.allCases
        var isCateogryExpandend: Bool = false
        var categoryToggleTitle: String { isCateogryExpandend ? "접기" : "더보기" }

        var isAnimated: Bool = false
        var carouselCurrentIndex: Int = 0
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

        case routeToSearch
        case routeToLiving
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .animatingList:
                state.isAnimated = true
                return .none
            case .indexChanged(let index):
                state.carouselCurrentIndex = index
                return .none
            case .toggleCategory:
                state.isCateogryExpandend.toggle()
                return .none
            default: return .none
            }
        }
    }
}
