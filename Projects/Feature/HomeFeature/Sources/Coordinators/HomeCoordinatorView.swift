//
//  HomeCoordinatorView.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

public struct HomeCoordinatorView: View {
    private let store: Store<HomeCoordinator.State, HomeCoordinator.Action>

    public init(store: Store<HomeCoordinator.State, HomeCoordinator.Action>) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                switch $0 {
                case .home:
                    CaseLet(
                        /HomeScreen.State.home,
                        action: HomeScreen.Action.home,
                         then: HomeView.init
                    )
                }
            }
        }
    }
}
