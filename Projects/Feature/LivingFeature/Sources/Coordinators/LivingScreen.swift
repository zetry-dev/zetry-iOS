//
//  LivingScreen.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface

public struct LivingScreen: Reducer {
    public enum State: Equatable {
        case living(LivingStore.State)
    }

    public enum Action {
        case living(LivingStore.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
        Scope(state: /State.living, action: /Action.living, child: {
            LivingStore()._printChanges()
        })
    }
}
