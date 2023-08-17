//
//  LaunchScreenView.swift
//  LaunchScreenFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct LaunchScreenView: View {
    var store: StoreOf<LaunchScreenReducer>
    public init(store: StoreOf<LaunchScreenReducer>) {
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
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView(
            store: .init(
                initialState: LaunchScreenReducer.State(),
                reducer: {
                    LaunchScreenReducer()
                }))
    }
}
