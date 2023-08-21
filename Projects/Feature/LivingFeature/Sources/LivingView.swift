//
//  LivingView.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zentry. All rights reserved.
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
            ScrollView {
                ForEach(0 ... 50, id: \.self) { _ in
                    Text("생활정보")
                }
            }
        }
    }
}
