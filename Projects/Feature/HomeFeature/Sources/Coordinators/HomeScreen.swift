//
//  HomeScene.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import TCACoordinators

public struct HomeScreen: Reducer {
    public enum State: Equatable {
        case home(HomeStore.State)
    }

    public enum Action {
        case home(HomeStore.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}