//
//  SearchScreen.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/23.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface

public struct SearchScreen: Reducer {
    public enum State: Equatable {
        case search(SearchStore.State)
    }

    public enum Action {
        case search(SearchStore.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
        Scope(state: /State.search, action: /Action.search, child: {
            SearchStore()._printChanges()
        })
    }
}
