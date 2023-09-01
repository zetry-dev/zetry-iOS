//
//  SearchCoordinatorView.swift
//  SearchFeature
//
//  Created by AllieKim on 2023/08/23.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import SwiftUI

public struct SearchCoordinatorView: View {
    private let store: StoreOf<SearchCoordinator>

    public init(store: StoreOf<SearchCoordinator>) {
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
