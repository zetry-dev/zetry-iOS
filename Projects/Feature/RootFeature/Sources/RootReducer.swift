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
        var launchScreen: LaunchScreenReducer.State?
        
        public init() {
            launchScreen = LaunchScreenReducer.State()
        }
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
        .ifLet(\.launchScreen, action: /Action.launchScreen) {
            LaunchScreenReducer()
        }
    }
}
