//
//  RootView.swift
//  RootFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct RootView: View {
    public let store: StoreOf<RootReducer>

    public init(store: StoreOf<RootReducer>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { _ in
            VStack {
                Text("hi")
            }
        }
    }
}
