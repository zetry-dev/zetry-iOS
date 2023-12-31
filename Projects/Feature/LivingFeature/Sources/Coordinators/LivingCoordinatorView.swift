//
//  LivingCoordinatorView.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
import SwiftUI
import TCACoordinators

public struct LivingCoordinatorView: View {
    private let store: StoreOf<LivingCoordinator>

    public init(store: StoreOf<LivingCoordinator>) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                switch $0 {
                case .living:
                    CaseLet(
                        /LivingScreen.State.living,
                        action: LivingScreen.Action.living,
                        then: LivingView.init
                    )
                case .livingSection:
                    CaseLet(
                        /LivingScreen.State.livingSection,
                        action: LivingScreen.Action.livingSection,
                        then: LivingSectionView.init
                    )
                }
            }
        }
    }
}
