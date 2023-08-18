//
//  HomeReducer.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture

public struct HomeReducer: Reducer {
    public init() {}

    public struct State: Equatable {
        public init() {}
    }

    public enum Action: Equatable {}

    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            default: return .none
            }
        }
    }
}
