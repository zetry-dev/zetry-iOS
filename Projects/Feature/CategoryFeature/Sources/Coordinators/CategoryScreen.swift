//
//  CategoryScreen.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import TCACoordinators

public struct CategoryScreen: Reducer {
    public enum State: Equatable {
        case category(CategoryStore.State)
    }

    public enum Action {
        case category(CategoryStore.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
