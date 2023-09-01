//
//  LivingView.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import DesignSystem
import SwiftUI

public struct LivingView: View {
    public let store: StoreOf<LivingStore>

    public init(store: StoreOf<LivingStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store) { $0 } content: { viewStore in
            VStack {
                SegmentedPicker(
                    viewStore.binding(
                        get: { $0.selectedSegment },
                        send: LivingStore.Action.selectedSegment
                    ),
                    segments: LivingSegementedTab.allCases
                )
                ScrollView {
                    if viewStore.selectedSegment == .tips {
                        Text("팁")
                    } else {
                        Text("상점")
                    }
                }
            }
        }
    }
}
