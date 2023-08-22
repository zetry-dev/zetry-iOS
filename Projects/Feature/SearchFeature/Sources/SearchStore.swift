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
        var keywords: [String] = []
        var searchResults: [String] = []

        public init() {}
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case search
        case searchKeywords
//        case dataLoaded(TaskResult<Model>)
    }

    @Dependency(\.continuousClock) var clock

    private enum DebounceSearchID { case debounce }

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(\.$query):
                if !state.query.isEmpty {
                    return .run { send in
                        try await clock.sleep(for: .seconds(1))
                        await send(.searchKeywords)
                    }
                    .cancellable(id: DebounceSearchID.debounce, cancelInFlight: true)
                } else {
                    return .none
                }
            case .search:
                print("query :: \(state.query)")
                return .none
//                return .run { [query = state.query] send in
//                    let result = await TaskResult {
//                        try await client.search(query)
//                    }
//                    await send(.dataLoaded(result))
//                }
            case .searchKeywords:
                print("keywords :: \(state.query)")
                return .none
            default: return .none
            }
        }
    }
}
