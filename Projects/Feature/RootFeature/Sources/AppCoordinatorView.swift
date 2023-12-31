//
//  AppCoordinatorView.swift
//  RootFeature
//
//  Created by Allie Kim on 2023/08/20.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import LaunchScreenFeature
import MainTabFeature
import ProductDetailFeature
import SearchFeature
import SwiftUI
import TCACoordinators
import WebViewFeature

public struct AppCoordinatorView: View {
    private let store: StoreOf<AppCoordinator>

    public init(store: StoreOf<AppCoordinator>) {
        self.store = store
    }

    public var body: some View {
        TCARouter(self.store) { screen in
            SwitchStore(screen) { initialState in
                switch initialState {
                case .launch:
                    CaseLet(
                        /AppScreen.State.launch,
                        action: AppScreen.Action.launch,
                        then: LaunchScreenView.init
                    )
                case .mainTab:
                    CaseLet(
                        /AppScreen.State.mainTab,
                        action: AppScreen.Action.mainTab,
                        then: MainTabView.init
                    )
                case .search:
                    CaseLet(
                        /AppScreen.State.search,
                        action: AppScreen.Action.search,
                        then: SearchView.init
                    )
                case .detail:
                    CaseLet(
                        /AppScreen.State.detail,
                        action: AppScreen.Action.detail,
                        then: ProductDetailView.init
                    )
                case .webview:
                    CaseLet(
                        /AppScreen.State.webview,
                        action: AppScreen.Action.webview,
                        then: WebviewView.init
                    )
                }
            }
        }
    }
}
