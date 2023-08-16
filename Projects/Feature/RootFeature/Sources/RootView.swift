//
//  RootView.swift
//  RootFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import LaunchScreenFeature
import MainTabFeature
import SwiftUI

public struct RootView: View {
    public let store: StoreOf<RootReducer>

    public init(store: StoreOf<RootReducer>) {
        self.store = store
    }

    public var body: some View {
        SwitchStore(self.store) { state in
            switch state {
            case .launchScreen:
                CaseLet(/RootReducer.State.launchScreen,
                        action: RootReducer.Action.launchScreen,
                        then: LaunchScreenView.init)

            case .mainTab:
                CaseLet(/RootReducer.State.mainTab,
                        action: RootReducer.Action.mainTab,
                        then: MainTabView.init)
            }
        }
    }
}
