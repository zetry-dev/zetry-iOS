//
//  CategoryCoordinatorView.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI
import TCACoordinators

public struct CategoryCoordinatorView: View {
    private let store: Store<CategoryCoordinator.State, CategoryCoordinator.Action>

    public init(store: Store<CategoryCoordinator.State, CategoryCoordinator.Action>) {
        self.store = store
    }

    public var body: some View {
        TCARouter(store) { screen in
            SwitchStore(screen) {
                switch $0 {
                case .category:
                    CaseLet(
                        /CategoryScreen.State.category,
                        action: CategoryScreen.Action.category,
                        then: CategoryView.init
                    )
                }
            }
        }
    }
}
