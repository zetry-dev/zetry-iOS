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
import Foundation
import ProductDomain
import ProductDomainInterface

public struct SearchStore: Reducer {
    public init() {}

    public struct State: Equatable {
        @BindingState var query: String = ""
        @BindingState var focusedField: Bool = false

        var items: [ProductEntity] = []

        var recentKeywords: [String]
        var recommendedKeywords: [String] = []
        var topKeywords: [String] = []
        var relatedKeywords: [String] = []
        var searchResults: [String] = []
        var updatedTimeStamp: String = "2023.08.08 업데이트"
        var isEmptyResult: Bool = false

        public init() {
            recentKeywords = UserDefaultsManager.recentKeywords
        }
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAppear

        case didTapSearch
        case didTapQuery(String)
        case didTapRemoveQuery(Int)
        case didTapRemoveAllQueries

        case fetchSearchKeywords
        case removeRelatedKeywords
        case addRecentKeyword
        case storeKeywords([ProductEntity])
        case updateTimeStamp

        case itemDataLoaded(TaskResult<[ProductEntity]>)
        case relatedQueryDataLoaded(TaskResult<[ProductEntity]>)

        case pop
        case routeToDetail(item: ProductEntity)
        case presentSearchFailure
    }

    @Dependency(\.categoryClient) private var categoryClient
    @Dependency(\.productClient) private var productClient
    @Dependency(\.continuousClock) private var clock

    private enum CancellableID {
        case debounce
        case fetchKeywords
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(\.$query):
                if !state.query.isEmpty {
                    return .run { send in
                        try await clock.sleep(for: .seconds(1))
                        await send(.fetchSearchKeywords)
                    }
                    .cancellable(id: CancellableID.debounce, cancelInFlight: true)
                } else {
                    return .none
                }
            case .onAppear:
                return .run { send in
                    let result = await TaskResult {
                        try await productClient.fetchAllItems()
                    }
                    await send(.itemDataLoaded(result))
                }
            case .didTapSearch:
                debugPrint("query :: \(state.query)")
                return .concatenate([
                    .run { [newState = state] send in
                        if let item = newState.items.first(where: { $0.title == newState.query }) {
                            await send(.routeToDetail(item: item))
                        } else {
                            await send(.presentSearchFailure)
                        }
                    },
                    .merge([
                        .send(.addRecentKeyword),
                        .send(.removeRelatedKeywords)
                    ])
                ])

            case .fetchSearchKeywords:
                // FIXME: didTapSearch 이후에 발생하지 않도록
                debugPrint("keywords :: \(state.query)")
                return .run { [newState = state] send in
                    let result = await TaskResult {
                        try await productClient.fetchItems(newState.query)
                    }
                    await send(.relatedQueryDataLoaded(result))
                }
                .cancellable(id: CancellableID.fetchKeywords, cancelInFlight: true)

            case .didTapQuery(let query):
                state.query = query
                return .send(.didTapSearch)

            case .didTapRemoveQuery(let index):
                UserDefaultsManager.recentKeywords.remove(at: index)
                state.recentKeywords.remove(at: index)
                return .none

            case .didTapRemoveAllQueries:
                UserDefaultsManager.recentKeywords = []
                state.recentKeywords = []
                return .none

            case .removeRelatedKeywords:
                state.relatedKeywords = []
                state.query = ""
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

            case .itemDataLoaded(.success(let result)):
                state.items = result

                return .run { send in
                    await send(.storeKeywords(result))
                    await send(.updateTimeStamp)
                }

            case .itemDataLoaded(.failure):
                state.recommendedKeywords = []
                return .none

            case .relatedQueryDataLoaded(.success(let result)):
                if !result.isEmpty {
                    state.relatedKeywords = result.map(\.title)
                }
                return .none
            case .presentSearchFailure:
                state.isEmptyResult = true
                return .none

            case .storeKeywords(let data):
                storeRandomKeywordIfNeeded(&UserDefaultsManager.recommendedKeywords, data: data)
                storeRandomKeywordIfNeeded(&UserDefaultsManager.topKeywords, data: data)

                state.recommendedKeywords = UserDefaultsManager.recommendedKeywords
                state.topKeywords = UserDefaultsManager.topKeywords
                return .none

            case .updateTimeStamp:
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy.MM.dd 업데이트"
                state.updatedTimeStamp = formatter.string(from: Date.now)
                return .none
            default: return .none
            }
        }
    }

    private func storeRandomKeywordIfNeeded(_ storedKeywords: inout [String], data: [ProductEntity]) {
        if storedKeywords.isEmpty ||
            !(Calendar.current.isDateInToday(UserDefaultsManager.keywordsDate)) {
            let keywords = data.map(\.title)
            let newKeywords = keywords.shuffled().prefix(10).map { String($0) }
            storedKeywords = newKeywords
        }
    }
}
