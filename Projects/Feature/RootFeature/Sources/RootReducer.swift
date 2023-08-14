//
//  RootStore.swift
//  RootFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import Foundation
import LaunchScreenFeature

public struct RootReducer: Reducer {
    public init() {}

    public struct State: Equatable {
        var launchScreen: LaunchScreenReducer.State = .init()

        public init() {}
    }

    public enum Action: Equatable {
        case launchScreen(LaunchScreenReducer.Action)
    }

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .launchScreen:
                state.launchScreen = .init()
                return .none
            }
        }
        Scope(state: \.launchScreen, action: /Action.launchScreen, child: {
            LaunchScreenReducer()
        })
    }
}
