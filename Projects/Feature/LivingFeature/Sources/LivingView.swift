//
//  LivingView.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct LivingView: View {
    public let store: StoreOf<LivingStore>

    public init(store: StoreOf<LivingStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { _ in
            Text("생활정보")
        }
    }
}
