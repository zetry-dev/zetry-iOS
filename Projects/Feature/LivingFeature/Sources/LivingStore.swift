//
//  LivingStore.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import DesignSystem

public enum LivingSegementedTab: Segments, CaseIterable, Equatable {
    case tips
    case today

    public var title: String {
        switch self {
        case .tips: return "알면 좋은 꿀팁"
        case .today: return "오늘의 상점"
        }
    }
}

public struct LivingStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var selectedSegment: LivingSegementedTab = .tips
        var segmentedTab: [LivingSegementedTab] = LivingSegementedTab.allCases

        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
        case selectedSegment(LivingSegementedTab)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .selectedSegment(let segment):
                state.selectedSegment = segment
                return .none
            default: return .none
            }
        }
        ._printChanges()
    }
}
