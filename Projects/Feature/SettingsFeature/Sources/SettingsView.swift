//
//  SettingsView.swift
//  SettingsFeature
//
//  Created by AllieKim on 2023/08/31.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import SwiftUI

public struct SettingsView: View {
    public let store: StoreOf<SettingsStore>

    public init(store: StoreOf<SettingsStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { _ in
            Text("settings")
        }
    }
}
