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
import MainTabFeature

public struct RootReducer: Reducer {
    public init() {}

    public enum State: Equatable {
        case launchScreen(LaunchScreenReducer.State)
        case mainTab(MainTabReducer.State)

        public init() {
            self = .launchScreen(.init())
//            self = .mainTab(.init())
        }
    }

    public enum Action: Equatable {
        case launchScreen(LaunchScreenReducer.Action)
        case mainTab(MainTabReducer.Action)
    }

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            // Core logic for parent feature
            switch action {
            case .launchScreen(.onDisappear):
                state = .mainTab(.init())
                return .none
            default:
                return .none
            }
        }
        .ifCaseLet(/State.mainTab, action: /Action.mainTab) {
            MainTabReducer()
        }
        .ifCaseLet(/State.launchScreen, action: /Action.launchScreen) {
            LaunchScreenReducer()
        }
    }
}
