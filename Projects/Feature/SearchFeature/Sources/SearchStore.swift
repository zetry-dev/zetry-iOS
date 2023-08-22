//
//  SearchStore.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture

public struct SearchStore: Reducer {
    public init() {}

    public struct State: Equatable {
        @BindingState var query: String = ""
        @BindingState var focusedField: Bool = false

        public init() {}
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { _, action in
            switch action {
            default: return .none
            }
        }
    }
}
