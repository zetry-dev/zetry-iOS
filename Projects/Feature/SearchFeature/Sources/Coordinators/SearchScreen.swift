//
//  SearchScreen.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/23.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import TCACoordinators

public struct SearchScreen: Reducer {
    public enum State: Equatable {
        case search(SearchStore.State)
    }

    public enum Action {
        case search(SearchStore.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
