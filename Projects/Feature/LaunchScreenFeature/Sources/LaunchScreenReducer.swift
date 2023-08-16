//
//  LaunchScreenReducer.swift
//  LaunchScreenFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import Foundation
import MainTabFeature

public struct LaunchScreenReducer: Reducer {
    public init() {}

    public enum State: Equatable {
        case onAppear
        case onDisappear

        public init() {
            self = .onAppear
        }
    }

    public enum Action: Equatable {
        case onAppear
        case onDisappear
    }

    enum CancelID { case onAppear }

    public var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.onDisappear)
                }
                .debounce(id: CancelID.onAppear, for: .seconds(2), scheduler: UIScheduler.shared)
            case .onDisappear:
                return .none
            }
        }
    }
}
