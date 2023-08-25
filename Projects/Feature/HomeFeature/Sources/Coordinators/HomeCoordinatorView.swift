//
//  HomeCoordinatorView.swift
//  HomeFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import SearchFeature
import SwiftUI
import TCACoordinators

public struct HomeCoordinatorView: View {
    private let store: StoreOf<HomeCoordinator>

    public init(store: StoreOf<HomeCoordinator>) {
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
                case .search:
                    CaseLet(
                        /HomeScreen.State.search,
                        action: HomeScreen.Action.search,
                        then: SearchView.init
                    )
                }
            }
        }
    }
}
