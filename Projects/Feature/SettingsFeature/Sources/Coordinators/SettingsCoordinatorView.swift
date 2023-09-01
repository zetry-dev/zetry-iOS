//
//  SettingsCoordinatorView.swift
//  SettingsFeature
//
//  Created by AllieKim on 2023/08/31.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import SwiftUI

public struct SettingsCoordinatorView: View {
    private let store: StoreOf<SettingsCoordinator>

    public init(store: StoreOf<SettingsCoordinator>) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                switch $0 {
                case .settings:
                    CaseLet(
                        /SettingsScreen.State.settings,
                        action: SettingsScreen.Action.settings,
                        then: SettingsView.init
                    )
                }
            }
        }
    }
}
