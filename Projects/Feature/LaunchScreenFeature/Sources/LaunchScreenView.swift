//
//  LaunchScreenView.swift
//  LaunchScreenFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import BaseFeatureInterface
import SwiftUI

public struct LaunchScreenView: View {
    private var store: StoreOf<LaunchScreenStore>

    public init(store: StoreOf<LaunchScreenStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { $0 } content: { viewStore in
            VStack {
                // TODO: - Add Launch Screen
                Text("Zetry")
                    .foregroundColor(.green)
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
        .navigationBarHidden(true)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(
            store: .init(
                initialState: LaunchScreenStore.State(),
                reducer: {
                    LaunchScreenStore()
                }))
    }
}
