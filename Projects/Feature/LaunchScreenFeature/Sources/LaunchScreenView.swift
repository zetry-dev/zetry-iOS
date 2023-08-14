//
//  LaunchScreenView.swift
//  LaunchScreenFeature
//
//  Created by AllieKim on 2023/08/14.
//  Copyright © 2023 com.zentry. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct LaunchScreenView: View {
    var store: StoreOf<LaunchScreenReducer>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("Zetry")
                .foregroundColor(.green)
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
