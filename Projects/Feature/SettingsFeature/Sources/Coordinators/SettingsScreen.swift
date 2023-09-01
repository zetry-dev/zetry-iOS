//
//  SettingsScreen.swift
//  SettingsFeature
//
//  Created by AllieKim on 2023/08/31.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface

public struct SettingsScreen: Reducer {
    public enum State: Equatable {
        case settings(SettingsStore.State)
    }

    public enum Action {
        case settings(SettingsStore.Action)
    }

    public var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
