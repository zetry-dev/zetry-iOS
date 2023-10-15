//
//  LivingView.swift
//  LivingFeature
//
//  Created by AllieKim on 2023/08/17.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeature
import ComposableArchitecture
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
                    segments: LivingSegementedTab.allCases,
                    segmentStyle: .button(.style)
                )
                .frame(maxWidth: .infinity)

                ScrollView {
                    LivingSectionView(
                        store: store.scope(
                            state: \.livingSectionStore,
                            action: LivingStore.Action.livingSection
                        )
                    )
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}
