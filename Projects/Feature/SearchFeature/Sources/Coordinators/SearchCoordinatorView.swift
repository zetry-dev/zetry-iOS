//
//  SearchCoordinatorView.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/23.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

public struct SearchCoordinatorView: View {
    private let store: Store<SearchCoordinator.State, SearchCoordinator.Action>

    public init(store: Store<SearchCoordinator.State, SearchCoordinator.Action>) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                switch $0 {
                case .search:
                    CaseLet(
                        /SearchScreen.State.search,
                        action: SearchScreen.Action.search,
                        then: SearchView.init
                    )
                }
            }
        }
    }
}
