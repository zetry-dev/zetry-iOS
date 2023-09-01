//
//  LaunchScreenStore.swift
//  LaunchScreenFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface

public struct LaunchScreenStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {
        case onAppear
        case onDisappear
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
