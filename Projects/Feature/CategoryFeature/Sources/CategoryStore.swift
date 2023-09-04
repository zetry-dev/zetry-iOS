//
//  CategoryStore.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import BaseFeatureInterface
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
        @BindingState var selectedSegment: CategorySegementedTab = .recyclable
        @BindingState var selectedCategory: ZetryCategory = .paper

        public init() {}
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case onAppear
        case didTapCategory(ZetryCategory)
        case routeToSearch
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .didTapCategory(let category):
                state.selectedCategory = category
                return .none
            default: return .none
            }
        }
    }
}
