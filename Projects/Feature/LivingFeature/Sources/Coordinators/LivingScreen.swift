//
//  LivingScreen.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import TCACoordinators

public struct LivingScreen: Reducer {
    public enum State: Equatable {
        case living(LivingStore.State)
    }

    public enum Action {
        case living(LivingStore.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
