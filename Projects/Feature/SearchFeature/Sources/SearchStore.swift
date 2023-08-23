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
        // TODO: - UserDefaults 적용
        var recentKeywords: [String] = ["종이컵", "비닐", "유리컵", "우산", "의자", "멀티탭", "모니터", "보조배터리", "커튼", "컵라면 용기"]
        var recommendedKeywords: [String] = ["종이컵", "비닐", "유리컵", "우산", "의자", "멀티탭", "모니터", "보조배터리", "커튼", "컵라면 용기"]
        var topKeywords: [String] = ["종이컵", "비닐", "유리컵", "우산", "의자", "멀티탭", "모니터", "보조배터리", "커튼", "컵라면 용기"]
        var relatedKeywords: [String] = []
        var searchResults: [String] = []

        var updatedTimeStamp: String = "2023.08.08 오후 7시 업데이트"

        public init() {}
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case search
        case didTapQuery(String)
        case searchKeywords
        case removeQuery(Int)
        case removeAllQueries
        case removeRelatedKeywords
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
                debugPrint("query :: \(state.query)")
                return .send(.removeRelatedKeywords)
//                return .run { [query = state.query] send in
//                    let result = await TaskResult {
//                        try await client.search(query)
//                    }
//                    await send(.dataLoaded(result))
//                }
            case .searchKeywords:
                debugPrint("keywords :: \(state.query)")
                // TODO: - 데이터 가져오기
                state.relatedKeywords = ["종이컵", "비닐", "유리컵", "우산", "의자", "멀티탭", "모니터", "보조배터리", "커튼", "컵라면 용기"]
                return .none
            case .didTapQuery(let query):
                state.query = query
                return .send(.search)
            case .removeQuery(let index):
                // TODO: - UserDefaults 적용
                state.recentKeywords.remove(at: index)
                return .none
            case .removeAllQueries:
                // TODO: - UserDefaults 적용
                state.recentKeywords = []
                return .none
            case .removeRelatedKeywords:
                state.relatedKeywords = []
                return .none
            default: return .none
            }
        }
    }
}
