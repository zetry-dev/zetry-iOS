//
//  LivingScreen.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import TCACoordinators

public struct LivingScreen: Reducer {
    public enum State: Equatable {
        case living(LivingStore.State)
        case livingSection(LivingSectionStore.State)
    }

    public enum Action {
        case living(LivingStore.Action)
        case livingSection(LivingSectionStore.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
        Scope(
            state: /State.living,
            action: /Action.living,
            child: {
                LivingStore()._printChanges()
            })
        Scope(
            state: /State.livingSection,
            action: /Action.livingSection,
            child: {
                LivingSectionStore()._printChanges()
            })
    }
}
