//
//  LivingStore.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import CoreKitInterface

public struct LivingStore: Reducer {
    public init() {}

    public struct State: Equatable {
        var livingSectionStore: LivingSectionStore.State = .init()
        var selectedSegment: LivingSegementedTab = .livingInfo
        var segmentedTab: [LivingSegementedTab] = LivingSegementedTab.allCases

        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
        case selectedSegment(LivingSegementedTab)
        case livingSection(LivingSectionStore.Action)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .selectedSegment(let segment):
                state.selectedSegment = segment
                state.livingSectionStore.selectedLivingTab = segment
                return .none
            default: return .none
            }
        }

        Scope(state: \.livingSectionStore, action: /Action.livingSection, child: {
            LivingSectionStore()
        })
    }
}
