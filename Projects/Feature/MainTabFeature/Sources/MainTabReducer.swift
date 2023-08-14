//
//  MainTabReducer.swift
//  MainTabFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture

public struct MainTabReducer: Reducer {
    public init() {}

    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {}

    public var body: some Reducer<State, Action> {
        Reduce { _, _ in
            .none
        }
    }
}
