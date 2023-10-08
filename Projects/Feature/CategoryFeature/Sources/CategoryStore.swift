//
//  CategoryStore.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import CategoryDomain
import CategoryDomainInterface
import ComposableArchitecture
import CoreKitInterface

public struct CategoryStore: Reducer {
    public init() {}

    public enum CategorySegementedTab: Segments, CaseIterable, Equatable {
        case recyclable
        case nonRecyclable

        public var title: String {
            switch self {
            case .recyclable: return "재활용 가능"
            case .nonRecyclable: return "재활용 불가능"
            }
        }
    }

    public struct State: Equatable {
        var categories: [CategoryEntity] = []
        @BindingState var selectedSegment: CategorySegementedTab = .recyclable
        @BindingState var selectedCategory: Int = 0

        public init() {}
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onLoad
        case didTapCategory(Int)

        case categoryDataLoaded(TaskResult<[CategoryEntity]>)

        case routeToSearch
    }

    @Dependency(\.categoryClient) private var categoryClient

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onLoad:
                return .run { send in
                    let result = await TaskResult {
                        try await categoryClient.fetchCategories()
                    }
                    await send(.categoryDataLoaded(result))
                }
            case let .didTapCategory(category):
                state.selectedCategory = category
                return .none
            case let .categoryDataLoaded(.success(result)):
                state.categories = result.sorted(by: <)
                return .none
            default: return .none
            }
        }
    }
}
