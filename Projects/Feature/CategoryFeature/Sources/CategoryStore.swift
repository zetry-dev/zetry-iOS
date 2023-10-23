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
import ProductDomain
import ProductDomainInterface

public struct CategoryStore: Reducer {
    public init() {}

    public enum CategorySegementedTab: Segments, CaseIterable, Equatable {
        case recyclable
        case nonRecyclable

        public var value: Bool {
            switch self {
            case .recyclable: return true
            case .nonRecyclable: return false
            }
        }

        public var title: String {
            switch self {
            case .recyclable: return "재활용 가능"
            case .nonRecyclable: return "재활용 불가능"
            }
        }
    }

    public struct State: Equatable {
        var categories: [CategoryEntity] = []
        var products: [ProductEntity] = []
        var selectedProducts: [ProductEntity] = []
        var selectedCategory: String
        @BindingState var selectedSegment: CategorySegementedTab = .recyclable

        public init(selectedCategory: String) {
            self.selectedCategory = selectedCategory
        }
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onLoad
        case onAppear
        case didTapCategory(String)

        case filterProducts

        case fetchCategories
        case fetchProducts
        case categoryDataLoaded(TaskResult<[CategoryEntity]>)
        case productDataLoaded(TaskResult<[ProductEntity]>)

        case routeToProductDetail(ProductEntity)
        case routeToSearch
    }

    @Dependency(\.categoryClient) private var categoryClient
    @Dependency(\.productClient) private var productClient

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(\.$selectedSegment):
                return .send(.filterProducts)
            case .onLoad:
                return .merge(
                    .send(.fetchCategories),
                    .send(.fetchProducts)
                )
            case .onAppear:
                if state.categories.isEmpty {
                    return .send(.onLoad)
                }
                return .none
            case let .didTapCategory(category):
                state.selectedCategory = category
                return .send(.filterProducts)
            case .filterProducts:
                state.selectedProducts = filterProducts(state: state)
                return .none
            case .fetchCategories:
                return .run { send in
                    let result = await TaskResult {
                        try await categoryClient.fetchCategories()
                    }
                    await send(.categoryDataLoaded(result))
                }
            case .fetchProducts:
                return .run { send in
                    let result = await TaskResult {
                        try await productClient.fetchAllItems()
                    }
                    await send(.productDataLoaded(result))
                }
            case let .categoryDataLoaded(.success(result)):
                state.categories = result.sorted(by: <)
                return .none
            case let .productDataLoaded(.success(result)):
                state.products = result
                return .send(.filterProducts)
            default: return .none
            }
        }
    }

    private func filterProducts(state: State) -> [ProductEntity] {
        state.products
            .filter {
                $0.category == state.selectedCategory && $0.recyclable == state.selectedSegment.value
            }
    }
}
