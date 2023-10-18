//
//  LivingSectionStore.swift
//  BaseFeature
//
//  Created by AllieKim on 2023/10/15.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import Foundation
import LivingDomainInterface

public struct LivingSectionStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public var selectedLivingTab: LivingSegementedTab
        public var livingSectionItems: [Int: [LivingSectionItem]] = [LivingSegementedTab.home.rawValue: Array(repeating: .init(), count: 2)]

        public init(selectedLivingTab: LivingSegementedTab = .home) {
            self.selectedLivingTab = selectedLivingTab
        }
    }

    public enum Action: Equatable {
        case view(View)
        case test
    }

    public var body: some ReducerOf<Self> {
        BindingReducer(action: /Action.view)

        Reduce { _, action in
            switch action {
            default:
                return .none
            }
        }
    }
}

public extension LivingSectionStore.Action {
    enum View: Equatable, BindableAction {
        case binding(BindingAction<LivingSectionStore.State>)
        case routeToLivingDetail(String)
    }
}
