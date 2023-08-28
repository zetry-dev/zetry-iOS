//
//  SearchStore.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/18.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import CategoryDomain
import CategoryDomainInterface
import ComposableArchitecture
import CoreKit

public struct SearchStore: Reducer {
    public init() {}

    public struct State: Equatable {
        @BindingState var query: String = ""
        @BindingState var focusedField: Bool = false
        var recentKeywords: [String]
        var recommendedKeywords: [String] = []
        var topKeywords: [String] = ["종이컵", "비닐", "유리컵", "우산", "의자", "멀티탭", "모니터", "보조배터리", "커튼", "컵라면 용기"]
        var relatedKeywords: [String] = []
        var searchResults: [String] = []
        var updatedTimeStamp: String = "2023.08.08 오후 7시 업데이트"

        public init() {
            recentKeywords = UserDefaultsManager.recentKeywords
        }
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAppear
        case search
        case didTapQuery(String)
        case searchKeywords
        case removeQuery(Int)
        case removeAllQueries
        case removeRelatedKeywords
        case addRecentKeyword
        case pop
        case recommendDataLoaded(TaskResult<CategoryEntity>)
    }

    @Dependency(\.categoryClient) var categoryClient
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
            case .onAppear:
                return .run { send in
                    let result = await TaskResult {
                        try await categoryClient.fetchSub()
                    }
                    await send(.recommendDataLoaded(result))
                }
            case .search:
                debugPrint("query :: \(state.query)")
                return .run { send in
                    await send(.removeRelatedKeywords)
                    await send(.addRecentKeyword)
                }
            case .searchKeywords:
                debugPrint("keywords :: \(state.query)")
                // TODO: - 데이터 가져오기
                state.relatedKeywords = [
                    "종이컵", "비닐", "유리컵", "우산", "의자", "멀티탭",
                    "모니터", "보조배터리", "커튼", "컵라면 용기", "종이컵",
                    "비닐", "유리컵", "우산", "의자", "종이컵", "비닐", "유리컵",
                    "우산", "의자", "종이컵", "비닐", "유리컵", "우산", "의자"
                ]
                return .none
            case .didTapQuery(let query):
                state.query = query
                return .send(.search)
            case .removeQuery(let index):
                UserDefaultsManager.recentKeywords.remove(at: index)
                state.recentKeywords.remove(at: index)
                return .none
            case .removeAllQueries:
                UserDefaultsManager.recentKeywords = []
                state.recentKeywords = []
                return .none
            case .removeRelatedKeywords:
                state.relatedKeywords = []
                return .none
            case .addRecentKeyword:
                let trimmedQuery = state.query.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmedQuery.isEmpty else {
                    return .none
                }

                if let index = state.recentKeywords.firstIndex(where: { $0 == trimmedQuery }) {
                    state.recentKeywords.remove(at: index)
                }

                state.recentKeywords.prepend(trimmedQuery)

                if state.recentKeywords.count > 20 {
                    state.recentKeywords.removeLast()
                }

                UserDefaultsManager.recentKeywords = state.recentKeywords
                return .none

            case .recommendDataLoaded(.success(let items)):
                state.recommendedKeywords = items.items.map(\.title)
                return .none
            case .recommendDataLoaded(.failure):
                state.recommendedKeywords = []
                return .none
            default: return .none
            }
        }
    }
}
