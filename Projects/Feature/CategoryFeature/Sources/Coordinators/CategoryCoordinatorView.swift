//
//  CategoryCoordinatorView.swift
//  CategoryFeature
//
//  Created by AllieKim on 2023/08/21.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import SwiftUI

public struct CategoryCoordinatorView: View {
    private let store: StoreOf<CategoryCoordinator>

    public init(store: StoreOf<CategoryCoordinator>) {
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
