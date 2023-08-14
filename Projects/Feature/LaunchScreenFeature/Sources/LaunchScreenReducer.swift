//
//  LaunchScreenReducer.swift
//  LaunchScreenFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import MainTabFeature

public struct LaunchScreenReducer: Reducer {
    public init() {}

    public struct State: Equatable {
        let mainTab = MainTabReducer.State()

        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
        case mainTab
    }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
        case .mainTab:
            return .none
        }
    }
}
